import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nextclean/controllers/session_controller.dart';
import 'package:nextclean/data/models/order.dart';
import 'package:nextclean/data/models/order_status.dart';
import 'package:nextclean/data/models/user_role.dart';
import 'package:nextclean/data/repositories/order_repository.dart';
import 'package:nextclean/data/repositories/storage_repository.dart';
import 'package:nextclean/utils/image_processor.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  bool _updating = false;

  String get _orderId => Get.parameters['id'] ?? '';

  bool _canEdit(UserRole role) {
    return role != UserRole.customer;
  }

  Future<void> _updateStatus(LaundryOrder order, OrderStatus newStatus) async {
    final session = Get.find<SessionController>();
    final repo = Get.find<OrderRepository>();
    final user = session.appUser.value;
    if (user == null) return;

    setState(() => _updating = true);
    try {
      await repo.updateOrderStatus(
        orderId: order.id,
        status: newStatus,
        updatedByUserId: user.id,
        now: DateTime.now(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal update status: $e')));
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  Future<void> _uploadPhoto(LaundryOrder order, String type) async {
    final session = Get.find<SessionController>();
    final storage = Get.find<StorageRepository>();
    final repo = Get.find<OrderRepository>();
    final user = session.appUser.value;
    if (user == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked == null) return;

    setState(() => _updating = true);
    try {
      final compressed = await ImageProcessor.compressToWebp(
        input: File(picked.path),
      );
      final url = await storage.uploadOrderPhoto(
        orderId: order.id,
        type: type,
        file: compressed,
      );
      await repo.updateOrderPhotoUrl(
        orderId: order.id,
        type: type,
        photoUrl: url,
        updatedByUserId: user.id,
        now: DateTime.now(),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal upload foto: $e')));
      }
    } finally {
      if (mounted) setState(() => _updating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = Get.find<OrderRepository>();
    final session = Get.find<SessionController>();

    if (_orderId.isEmpty) {
      return const Scaffold(body: Center(child: Text('Order ID tidak valid.')));
    }

    return Obx(() {
      final user = session.appUser.value;
      final role = user?.role ?? UserRole.customer;
      final canEdit = _canEdit(role);

      return Scaffold(
        appBar: AppBar(title: Text('Order #$_orderId')),
        body: StreamBuilder<LaundryOrder?>(
          stream: repo.watchOrderById(_orderId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final order = snapshot.data;
            if (order == null) {
              return const Center(child: Text('Order tidak ditemukan.'));
            }

            final statuses = OrderStatus.values;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'QR Code',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Center(child: QrImageView(data: order.id, size: 220)),
                        const SizedBox(height: 12),
                        SelectableText(
                          'ID: ${order.id}',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text('Customer: ${order.customerName ?? '-'}'),
                        Text('Total: Rp ${order.totalAmount}'),
                        Text('Status: ${order.status.label}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Update Status',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<OrderStatus>(
                          key: ValueKey(order.status.key),
                          initialValue: order.status,
                          items: statuses
                              .map(
                                (s) => DropdownMenuItem(
                                  value: s,
                                  child: Text(s.label),
                                ),
                              )
                              .toList(),
                          onChanged: !canEdit || _updating
                              ? null
                              : (s) {
                                  if (s == null) return;
                                  if (s == order.status) return;
                                  _updateStatus(order, s);
                                },
                          decoration: const InputDecoration(
                            labelText: 'Status',
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (!canEdit)
                          const Text('Role customer: read-only.')
                        else if (_updating)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Foto',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        _PhotoBlock(
                          title: 'BEFORE',
                          url: order.beforePhotoUrl,
                          canUpload:
                              canEdit &&
                              !_updating &&
                              role != UserRole.customer,
                          onUpload: () => _uploadPhoto(order, 'before'),
                        ),
                        const SizedBox(height: 12),
                        _PhotoBlock(
                          title: 'AFTER',
                          url: order.afterPhotoUrl,
                          canUpload:
                              canEdit &&
                              !_updating &&
                              role != UserRole.customer,
                          onUpload: () => _uploadPhoto(order, 'after'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'History',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        if (order.statusHistory.isEmpty)
                          const Text('-')
                        else
                          ...order.statusHistory.reversed.map((e) {
                            final status = e['status']?.toString() ?? '-';
                            final by = e['by']?.toString() ?? '-';
                            final at = e['at'];
                            final atText = at is Timestamp
                                ? at.toDate().toString()
                                : at?.toString() ?? '-';
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text('$status • $atText • $by'),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

class _PhotoBlock extends StatelessWidget {
  final String title;
  final String? url;
  final bool canUpload;
  final VoidCallback onUpload;

  const _PhotoBlock({
    required this.title,
    required this.url,
    required this.canUpload,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            ElevatedButton(
              onPressed: canUpload ? onUpload : null,
              child: const Text('Upload'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (url == null || url!.isEmpty)
          const Text('Belum ada foto.')
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(url!, height: 220, fit: BoxFit.cover),
          ),
      ],
    );
  }
}
