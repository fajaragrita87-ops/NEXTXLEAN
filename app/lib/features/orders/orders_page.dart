import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/controllers/session_controller.dart';
import 'package:nextclean/data/models/order.dart';
import 'package:nextclean/data/models/user_role.dart';
import 'package:nextclean/data/repositories/order_repository.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionController>();
    final repo = Get.find<OrderRepository>();

    return Obx(() {
      final user = session.appUser.value;
      if (user == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final String? branchId = switch (user.role) {
        UserRole.owner => null,
        UserRole.customer => null,
        _ => user.branchId,
      };

      final String? customerId = user.role == UserRole.customer
          ? user.id
          : null;

      return Scaffold(
        appBar: AppBar(title: const Text('Orders / Tracking')),
        body: StreamBuilder<List<LaundryOrder>>(
          stream: repo.watchRecentOrders(
            branchId: branchId,
            customerId: customerId,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            final orders = snapshot.data ?? const <LaundryOrder>[];
            if (orders.isEmpty) {
              return const Center(child: Text('Belum ada order.'));
            }
            return ListView.separated(
              itemCount: orders.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Text(
                    '${order.status.key} • Rp ${order.totalAmount}',
                  ),
                  trailing: const Icon(Icons.qr_code_2),
                  onTap: () => Get.toNamed('${AppRoutes.orders}/${order.id}'),
                );
              },
            );
          },
        ),
      );
    });
  }
}
