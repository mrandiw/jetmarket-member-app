// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'config/app_config.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

Future<void> main() async {
  await AppConfig.init();

  // Initialize Indonesian locale for date formatting
  await initializeDateFormatting('id_ID', null);

  var initialRoute = await Routes.initialRoute;

  runApp(Main(initialRoute));
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
