// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:dart_ping/dart_ping.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../infrastructure/theme/app_text.dart';

class AppConnectivityCheck extends StatefulWidget {
  const AppConnectivityCheck({super.key, required this.child, this.onRefresh})
      : super();

  final Widget child;
  final Function()? onRefresh;

  @override
  _AppConnectivityCheckState createState() => _AppConnectivityCheckState();
}

class _AppConnectivityCheckState extends State<AppConnectivityCheck> {
  // late Connectivity _connectivity;
  final ping = Ping('google.com', timeout: 10, interval: 3);
  late bool _isConnected;

  @override
  void initState() {
    super.initState();
    _isConnected = true;
    ping.stream.listen((event) {
      log("PING => $event");
      if (event.error?.error == ErrorType.requestTimedOut) {
        log("Sekarang Putus");
        // setState(() {
        //   _isConnected = false;
        // });
        Get.rawSnackbar(
          messageText:
              Text('Tidak ada koneksi internet', style: text12WhiteMedium),
          isDismissible: false,
          duration: 1.days,
          backgroundColor: kErrorColor,
          icon: Icon(Icons.wifi_off, color: kWhite, size: 35.r),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED,
        );
      } else {
        log("Sekarang Nyambung");
        if (Get.isSnackbarOpen) {
          Get.closeAllSnackbars();
        }

        // setState(() {
        //   _isConnected = true;
        // });
      }
    }, onError: (e) {
      setState(() {
        _isConnected = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    ping.stop();
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected ? widget.child : _buildNoConnectionWidget();
  }

  Widget _buildNoConnectionWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: AppStyle.paddingAll16,
      color: kWhite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton.primary(
              text: 'Refresh',
              onPressed: widget.onRefresh,
            ),
            Gap(12.h),
            AppButton.secondary(
              text: 'Keluar',
              onPressed: () => SystemNavigator.pop(),
            )
          ],
        ),
      ),
    );
  }
}
