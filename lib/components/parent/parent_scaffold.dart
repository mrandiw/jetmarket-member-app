import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import '../../../utils/network/screen_status.dart';

class ParentScaffold extends StatelessWidget {
  const ParentScaffold(
      {super.key,
      required this.onLoading,
      this.onError,
      this.message,
      required this.onSuccess,
      required this.status,
      this.onTimeout});

  final ScreenStatus status;
  final Widget onLoading;
  final Widget? onError;
  final String? message;
  final Widget onSuccess;
  final Widget? onTimeout;

  @override
  Widget build(BuildContext context) {
    if (status == ScreenStatus.loading) {
      return onLoading;
    } else if (status == ScreenStatus.failed) {
      return errorPage(
          errorMessage: message ??
              'Terjadi Kesalahan Pada Sistem, Mohon Maaf Atas Ketidak Nyamanannya');
    } else if (status == ScreenStatus.success) {
      return onSuccess;
    } else if (status == ScreenStatus.timeout) {
      return errorPage();
    } else {
      return const SizedBox();
    }
  }

  Widget errorPage({String errorMessage = ""}) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: kWhite,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                "Oops!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Kembali"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
