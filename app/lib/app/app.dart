import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextclean/app/bindings/initial_binding.dart';
import 'package:nextclean/app/routes/app_pages.dart';
import 'package:nextclean/app/routes/app_routes.dart';
import 'package:nextclean/app/theme/app_theme.dart';

class NextCleanApp extends StatelessWidget {
  const NextCleanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NEXTCLEAN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}

