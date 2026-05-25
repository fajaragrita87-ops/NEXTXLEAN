import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/controllers/auth_controller.dart';
import 'package:nextclean/controllers/session_controller.dart';
import 'package:nextclean/data/models/user_role.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Get.find<SessionController>();
    final auth = Get.find<AuthController>();

    return Obx(() {
      if (!session.isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => Get.offAllNamed(AppRoutes.login),
        );
        return const Scaffold(body: SizedBox.shrink());
      }

      final user = session.appUser.value;
      if (user == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final role = user.role;
      final items = _menuForRole(role);

      return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard (${role.name})'),
          actions: [
            IconButton(onPressed: auth.logout, icon: const Icon(Icons.logout)),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name ?? 'User',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.email ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Branch: ${user.branchId ?? '-'}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(item.route),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.label),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<_MenuItem> _menuForRole(UserRole role) {
    final base = <_MenuItem>[
      const _MenuItem(label: 'Notifikasi', route: AppRoutes.notifications),
    ];

    switch (role) {
      case UserRole.owner:
        return [
          const _MenuItem(label: 'POS / Order Baru', route: AppRoutes.pos),
          const _MenuItem(label: 'Scan QR', route: AppRoutes.scan),
          const _MenuItem(label: 'Order / Tracking', route: AppRoutes.orders),
          const _MenuItem(label: 'Absen Staff', route: AppRoutes.attendance),
          ...base,
        ];
      case UserRole.manager:
        return [
          const _MenuItem(label: 'Scan QR', route: AppRoutes.scan),
          const _MenuItem(label: 'Order / Tracking', route: AppRoutes.orders),
          const _MenuItem(label: 'Absen Staff', route: AppRoutes.attendance),
          ...base,
        ];
      case UserRole.kasir:
        return [
          const _MenuItem(label: 'POS / Order Baru', route: AppRoutes.pos),
          const _MenuItem(label: 'Scan QR', route: AppRoutes.scan),
          const _MenuItem(label: 'Order / Tracking', route: AppRoutes.orders),
          ...base,
        ];
      case UserRole.staff:
        return [
          const _MenuItem(label: 'Scan QR', route: AppRoutes.scan),
          const _MenuItem(label: 'Order / Tracking', route: AppRoutes.orders),
          const _MenuItem(label: 'Absen', route: AppRoutes.attendance),
          ...base,
        ];
      case UserRole.kurir:
        return [
          const _MenuItem(label: 'Scan QR', route: AppRoutes.scan),
          const _MenuItem(label: 'Order / Tracking', route: AppRoutes.orders),
          const _MenuItem(label: 'Absen', route: AppRoutes.attendance),
          ...base,
        ];
      case UserRole.customer:
        return [
          const _MenuItem(
            label: 'Order Saya / Tracking',
            route: AppRoutes.orders,
          ),
          ...base,
        ];
    }
  }
}

class _MenuItem {
  final String label;
  final String route;

  const _MenuItem({required this.label, required this.route});
}
