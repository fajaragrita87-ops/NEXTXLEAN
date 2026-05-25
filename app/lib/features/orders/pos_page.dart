import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/controllers/session_controller.dart';
import 'package:nextclean/data/repositories/order_repository.dart';

class PosPage extends StatefulWidget {
  const PosPage({super.key});

  @override
  State<PosPage> createState() => _PosPageState();
}

class _PosPageState extends State<PosPage> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _totalAmountController = TextEditingController(text: '0');
  final _openOrderIdController = TextEditingController();

  bool _isLoading = false;
  String? _lastOrderId;

  @override
  void dispose() {
    _customerNameController.dispose();
    _totalAmountController.dispose();
    _openOrderIdController.dispose();
    super.dispose();
  }

  Future<void> _createOrder() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final session = Get.find<SessionController>();
    final repo = Get.find<OrderRepository>();
    final user = session.appUser.value;
    if (user == null) return;

    final totalAmount =
        int.tryParse(_totalAmountController.text.replaceAll('.', '')) ?? 0;

    setState(() {
      _isLoading = true;
    });
    try {
      final orderId = await repo.createOrder(
        createdByUserId: user.id,
        now: DateTime.now(),
        branchId: user.branchId,
        customerName: _customerNameController.text.trim().isEmpty
            ? null
            : _customerNameController.text.trim(),
        totalAmount: totalAmount,
      );
      setState(() {
        _lastOrderId = orderId;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Order dibuat: $orderId')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal buat order: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('POS / Order Baru')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Buat Order',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _customerNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Customer (opsional)',
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _totalAmountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Total (angka)',
                        ),
                        validator: (v) {
                          final value = int.tryParse(
                            (v ?? '').replaceAll('.', ''),
                          );
                          if (value == null) return 'Total wajib angka';
                          if (value < 0) return 'Total tidak valid';
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _createOrder,
                        child: Text(
                          _isLoading ? 'Loading...' : 'Buat Order + QR',
                        ),
                      ),
                      if (_lastOrderId != null) ...[
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () =>
                              Get.toNamed('${AppRoutes.orders}/$_lastOrderId'),
                          child: const Text('Buka Detail Order Terakhir'),
                        ),
                      ],
                    ],
                  ),
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
                      'Buka Order (simulate scan)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _openOrderIdController,
                      decoration: const InputDecoration(labelText: 'Order ID'),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        final id = _openOrderIdController.text.trim();
                        if (id.isEmpty) return;
                        Get.toNamed('${AppRoutes.orders}/$id');
                      },
                      child: const Text('Buka'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
