import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../infrastructure/theme/app_colors.dart';

class CustomExpansion extends StatefulWidget {
  const CustomExpansion(
      {super.key,
      this.title,
      this.content,
      this.isExpanded = false,
      this.onTap,
      this.onExpansionChanged});

  final String? title;
  final Widget? content;
  final bool isExpanded;
  final Function()? onTap;
  final Function(bool)? onExpansionChanged;

  @override
  State<CustomExpansion> createState() => _CustomExpansionState();
}

class _CustomExpansionState extends State<CustomExpansion> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingBottom8,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                widget.onExpansionChanged?.call(!widget.isExpanded);
              },
              child: Container(
                width: Get.width.wr,
                padding: widget.isExpanded
                    ? AppStyle.paddingVert8
                    : EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.title ?? 'Title',
                        style: text14BlackMedium,
                      ),
                    ),
                    Icon(
                      widget.isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: kBlack,
                    )
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: 300.milliseconds,
              curve: Curves.easeInOut,
              child: Visibility(
                visible: widget.isExpanded,
                child: widget.content != null
                    ? Container(
                        width: Get.width.wr,
                        padding: AppStyle.paddingAll12,
                        decoration: BoxDecoration(
                            color: kBorder,
                            borderRadius: AppStyle.borderRadius8All),
                        child: widget.content,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ));
  }
}
