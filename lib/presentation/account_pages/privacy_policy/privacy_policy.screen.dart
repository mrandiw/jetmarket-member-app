import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'controllers/privacy_policy.controller.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  late final PrivacyPolicyController controller;
  WebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<PrivacyPolicyController>();
  }

  void _initWebView(String htmlContent) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFFF8F9FA))
      ..loadHtmlString(htmlContent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: kBlack, size: 20.r),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            color: kBlack,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<PrivacyPolicyController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(color: kPrimaryColor),
            );
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48.r, color: kSoftGrey),
                  SizedBox(height: 16.h),
                  Text(
                    controller.errorMessage!,
                    style: TextStyle(
                      color: kSoftGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => controller.refreshData(),
                    child: Text(
                      'Coba Lagi',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.htmlContent.isEmpty) {
            return Center(
              child: Text(
                'Privacy Policy belum tersedia',
                style: TextStyle(
                  color: kSoftGrey,
                  fontSize: 14.sp,
                ),
              ),
            );
          }

          // Initialize WebView with HTML content
          if (webViewController == null) {
            _initWebView(controller.htmlContent);
          }

          return WebViewWidget(controller: webViewController!);
        },
      ),
    );
  }
}
