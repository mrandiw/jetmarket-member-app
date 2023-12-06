import 'package:flutter/material.dart';
import '../../utils/network/screen_status.dart';

class ParentBody extends StatelessWidget {
  const ParentBody(
      {super.key,
      required this.onLoading,
      required this.onError,
      required this.onSuccess,
      required this.status});

  final ScreenStatus status;
  final Widget onLoading;
  final Widget onError;
  final Widget onSuccess;

  @override
  Widget build(BuildContext context) {
    if (status == ScreenStatus.loading) {
      return onLoading;
    } else if (status == ScreenStatus.failed) {
      return onError;
    } else if (status == ScreenStatus.success) {
      return onSuccess;
    } else {
      return const SizedBox();
    }
  }
}
