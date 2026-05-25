import 'package:get/get.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/features/attendance/attendance_page.dart';
import 'package:nextclean/features/auth/login_page.dart';
import 'package:nextclean/features/dashboard/dashboard_page.dart';
import 'package:nextclean/features/notifications/notifications_page.dart';
import 'package:nextclean/features/scan/scan_page.dart';
import 'package:nextclean/features/orders/orders_page.dart';
import 'package:nextclean/features/orders/order_detail_page.dart';
import 'package:nextclean/features/orders/pos_page.dart';
import 'package:nextclean/features/splash/splash_page.dart';

class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.dashboard, page: () => const DashboardPage()),
    GetPage(name: AppRoutes.pos, page: () => const PosPage()),
    GetPage(name: AppRoutes.orders, page: () => const OrdersPage()),
    GetPage(name: AppRoutes.orderDetail, page: () => const OrderDetailPage()),
    GetPage(name: AppRoutes.scan, page: () => const ScanPage()),
    GetPage(name: AppRoutes.attendance, page: () => const AttendancePage()),
    GetPage(name: AppRoutes.notifications, page: () => const NotificationsPage()),
  ];
}
