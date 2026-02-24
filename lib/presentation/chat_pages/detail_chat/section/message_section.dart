import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/controllers/detail_chat.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/picker/picker_images.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/assets/assets_svg.dart';

class MessageSection extends StatelessWidget {
  const MessageSection({super.key, required this.controller});

  final DetailChatController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailChatController>(builder: (controller) {
      return Stack(
        children: [
          if (controller.dataArgument != null &&
              controller.dataArgument!.variants != null)
            Positioned(
              bottom: 7.hr,
              left: 17.wr,
              right: 17.wr,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  8.wr,
                  8.wr,
                  8.wr,
                  controller.maxLines <= 2
                      ? 56.hr
                      : (56 + (controller.maxLines * 5)).hr,
                ),
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: kBorder)),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: controller.dataArgument!.variants?.image ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: kSofterGrey,
                          borderRadius: AppStyle.borderRadius8All,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const CupertinoActivityIndicator(color: kSoftBlack),
                      errorWidget: (context, url, error) => Container(
                        height: 50.h,
                        width: 50.h,
                        decoration: BoxDecoration(
                          color: kSofterGrey,
                          borderRadius: AppStyle.borderRadius6All,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: kPrimaryColor,
                            size: 18.r,
                          ),
                        ),
                      ),
                    ),
                    Gap(8.wr),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            controller.dataArgument!.variants?.name ?? '',
                            style: text12BlackMedium,
                            maxLines: 1,
                          ),
                          Gap(4.hr),
                          Row(
                            children: [
                              Text(
                                "${controller.dataArgument!.variants!.promo! > 0 ? controller.dataArgument!.variants?.promo : controller.dataArgument!.variants?.price}"
                                    .toIdrFormat,
                                style: text12BlackRegular,
                              ),
                              Gap(8.wr),
                              if (controller.dataArgument!.variants!.promo! >
                                      0 &&
                                  controller.dataArgument!.variants!.promo! !=
                                      controller.dataArgument!.variants!.price!)
                                Text(
                                  "${controller.dataArgument!.variants?.price}"
                                      .toIdrFormat,
                                  style: text10lineThroughRegular,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 7.hr,
            left: 17.wr,
            right: 17.wr,
            child: Visibility(
                visible: controller.pinnedMessage != null,
                child: Container(
                  height: controller.maxLines <= 2
                      ? 120.hr
                      : (120 + (controller.maxLines * 5)).hr,
                  width: Get.width,
                  padding: EdgeInsets.fromLTRB(
                    8.wr,
                    8.wr,
                    8.wr,
                    controller.maxLines <= 2
                        ? 56.hr
                        : (56 + (controller.maxLines * 5)).hr,
                  ),
                  decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kBorder)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: Get.width,
                        padding: AppStyle.paddingAll8,
                        decoration: BoxDecoration(
                            color: const Color(0xffDFDFDF),
                            border: Border(
                                left: BorderSide(
                                    color: controller.pinnedMessage?.isSender ==
                                            true
                                        ? const Color(0xff87FF8B)
                                        : const Color(0xffFF8787),
                                    width: 2))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.pinnedMessage?.isSender == true
                                  ? 'Anda'
                                  : controller.dataArgument?.name ?? '',
                              style: text12BlackMedium,
                            ),
                            Text(
                              controller.pinnedMessage?.text ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: text12BlackRegular.copyWith(
                                  color:
                                      const Color(0xff333333).withValues(alpha: 0.8)),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                          right: -5,
                          top: -5,
                          child: GestureDetector(
                            onTap: () => controller.cancelPinMessage(),
                            child: Container(
                                height: 16.r,
                                width: 16.r,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade500),
                                child: Center(
                                    child: Icon(
                                  Icons.close_rounded,
                                  color: kWhite,
                                  size: 14.r,
                                ))),
                          )),
                    ],
                  ),
                )),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                height: controller.maxLines <= 2
                    ? 56.hr
                    : (56 + (controller.maxLines * 5)).hr,
                padding: EdgeInsets.fromLTRB(16.wr, 0, 16.wr, 6.hr),
                decoration: const BoxDecoration(
                    color: Colors.transparent, borderRadius: BorderRadius.zero),
                child: SizedBox(
                  width: Get.width.wr,
                  height: controller.maxLines <= 2
                      ? 48.hr
                      : (48 + (controller.maxLines * 5)).hr,
                  child: TextFormField(
                      controller: controller.messageController,
                      focusNode: controller.focusNode,
                      style: text12BlackRegular,
                      maxLines: controller.maxLines,
                      onChanged: controller.listenMessageLenght,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: kWhite,
                          hintText: 'Tulis Pesan...',
                          hintStyle: text12HintForm,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 8.hr, horizontal: 12.wr),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                width: 1,
                                color: kBorder,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                width: 1,
                                color: kBorder,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                width: 1,
                                color: kBorder,
                              )),
                          prefixIcon: GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                  enterBottomSheetDuration: 200.milliseconds,
                                  exitBottomSheetDuration: 200.milliseconds,
                                  PickerImages.double(
                                    onTapCamera: () =>
                                        controller.getImageMenu(),
                                    onTapGallery: () =>
                                        controller.getImageGalery(),
                                  ));
                            },
                            child: SizedBox(
                              height: 20.r,
                              width: 20.r,
                              child: Center(
                                child: SvgPicture.asset(
                                  solarGallery,
                                  height: 24.r,
                                  width: 24.r,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () => controller.sendNewMessage(),
                            child: const Icon(
                              Icons.send_rounded,
                              color: kPrimaryColor,
                            ),
                          ))),
                )),
          ),
        ],
      );
    });
  }
}
