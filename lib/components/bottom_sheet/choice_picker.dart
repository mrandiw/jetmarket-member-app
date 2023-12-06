import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../utils/assets/assets_svg.dart';

class ChoicePicker extends StatelessWidget {
  const ChoicePicker.single(
      {super.key, this.isDouble = false, this.onTapCamera, this.onTapGallery});
  const ChoicePicker.double(
      {super.key, this.isDouble = true, this.onTapCamera, this.onTapGallery});

  final bool isDouble;
  final GestureTapCallback? onTapCamera;
  final GestureTapCallback? onTapGallery;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      height: 120.h,
      width: Get.width,
      decoration: const BoxDecoration(
        color: kMain,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12.w),
          isDouble != false
              ? GestureDetector(
                  onTap: onTapCamera,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 32.w,
                        width: 32.w,
                        child: SvgPicture.asset(camera),
                      ),
                      SizedBox(height: 6.w),
                      Text('Camera',
                          style: GoogleFonts.inter(
                              fontSize: 12, color: kSofterBlack))
                    ],
                  ),
                )
              : const SizedBox(),
          isDouble != false ? SizedBox(width: 26.w) : const SizedBox(),
          GestureDetector(
            onTap: onTapGallery,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 32.w,
                  width: 32.w,
                  child: SvgPicture.asset(photoGallery),
                ),
                SizedBox(height: 6.w),
                Text('Gallery',
                    style: GoogleFonts.inter(fontSize: 12, color: kSofterBlack))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
