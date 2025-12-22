// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/app_config.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'presentation/maintenance/maintenance_page.dart';
import 'utils/maintenance_service.dart';
import 'utils/app_preference/app_preferences.dart';

Future<void> main() async {
  await AppConfig.init();

  // Initialize Indonesian locale for date formatting
  await initializeDateFormatting('id_ID', null);

  final token = AppPreference().getAccessToken();
  final isLoggedIn = token != null && token.isNotEmpty;
  if (isLoggedIn) {
    final maintenance = await MaintenanceService().fetchStatus('member');
    final isBypass = _isMaintenanceBypass();
    if (maintenance.isMaintenance && !isBypass) {
      runApp(ScreenUtilInit(
          designSize: const Size(360, 800),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, widgets) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(useMaterial3: true),
              getPages: Nav.routes,
              home: MaintenancePage(message: maintenance.message),
            );
          }));
      return;
    }
  }

  var initialRoute = await Routes.initialRoute;

  runApp(Main(initialRoute));
}

bool _isMaintenanceBypass() {
  const bypassEmail = 'super@admin.com';
  final email = AppPreference().getEmail();
  return email?.toLowerCase() == bypassEmail;
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widgets) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GetMaterialApp(
              initialRoute: initialRoute,
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              theme: ThemeData(
                  useMaterial3: true,
                  bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent)),
              getPages: Nav.routes,
            ),
          );
        });
  }
}
