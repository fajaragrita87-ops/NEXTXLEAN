import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/controllers/session_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final session = Get.find<SessionController>();

    if (!session.isLoggedIn) {
      Get.offAllNamed(AppRoutes.login);
      return;
    }

    for (int i = 0; i < 30; i++) {
      final user = session.appUser.value;
      if (user != null) {
        if (!session.isUserActive) {
          await session.auth.signOut();
          Get.offAllNamed(AppRoutes.login);
          return;
        }
        Get.offAllNamed(AppRoutes.dashboard);
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    }

    Get.offAllNamed(AppRoutes.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'NEXTCLEAN',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

