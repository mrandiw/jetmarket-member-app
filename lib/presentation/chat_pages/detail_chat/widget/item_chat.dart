import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/chat_pages/detail_chat/controllers/detail_chat.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../domain/core/model/model_data/chat_model.dart';
import '../../../../utils/style/app_style.dart';

class ItemChat extends StatelessWidget {
  const ItemChat(
      {Key? key,
      required this.data,
      required this.isSender,
      required this.isReplySender,
      required this.index,
      required this.controller,
      this.onHorizontalDragStart,
      this.onLongPress,
      this.onTapCancel,
      required this.timeWidget})
      : super(key: key);

  final ChatModel data;
  final bool isSender;
  final bool isReplySender;
  final int index;
  final DetailChatController controller;
  final Function(DragStartDetails)? onHorizontalDragStart;
  final Function()? onLongPress;
  final Function()? onTapCancel;
  final Widget timeWidget;

  @override
  Widget build(BuildContext context) {
    double sellerNameLenght =
        controller.dataArgument?.name?.length.toDouble() ?? 0;
    double replyLenght = data.pinnedMessage?.text?.length.toDouble() ?? 0;
    double textLenght = data.text?.length.toDouble() ?? 0;
    double maxWidth = Get.width.wr * 0.8;
    double minWidth = [sellerNameLenght, replyLenght, textLenght]
        .reduce((max, value) => max > value ? max : value);
    return Padding(
      padding: AppStyle.paddingBottom12,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(child: timeWidget),
          Visibility(
            visible: data.pinnedProduct != null,
            child: data.deletedAt == null
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                          child: data.deletedAt == null
                              ? itemProduct()
                              : deletedItem()),
                      itemSelectDelete(),
                      itemHighlightScroll()
                    ],
                  )
                : deletedItem(),
          ),
          Visibility(
            visible: data.image != null && data.image != '',
            child: data.deletedAt == null
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        child: data.deletedAt == null
                            ? itemImage()
                            : deletedItem(),
                      ),
                      itemSelectDelete(),
                      itemHighlightScroll()
                    ],
                  )
                : deletedItem(),
          ),
          Visibility(
            visible: data.text != null && data.text != '',
            child: data.deletedAt == null
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      itemWithReply(minWidth, maxWidth),
                      itemSelectDelete(),
                      itemHighlightScroll()
                    ],
                  )
                : deletedItem(),
          )
        ],
      ),
    );
  }

  Widget itemWithReply(double minWidth, double maxWidth) {
    return Obx(() {
      return Transform.translate(
        offset: Offset(
            controller.indexSlide.value == index
                ? isSender
                    ? -controller.positionSlideChat.value
                    : controller.positionSlideChat.value
                : 0,
            0),
        child: GestureDetector(
          onLongPress: onLongPress,
          onHorizontalDragStart: onHorizontalDragStart,
          child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment:
                  !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: !isSender ? 16.wr : 0, right: isSender ? 16.wr : 0),
                  child: Column(
                    crossAxisAlignment: isSender
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: maxWidth,
                            minWidth:
                                minWidth > maxWidth ? maxWidth : minWidth),
                        child: Container(
                          padding: data.pinnedMessage != null
                              ? EdgeInsets.fromLTRB(6.wr, 6.hr, 6.wr, 8.hr)
                              : AppStyle.paddingAll12,
                          decoration: BoxDecoration(
                              borderRadius: AppStyle.borderRadius8All,
                              color: isSender
                                  ? const Color(0xffF9F7F7)
                                  : const Color(0xffFFE4E2)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: data.pinnedMessage != null,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.scrollToOriginalMessage(
                                      data.pinnedMessage?.text ?? 'No Text',
                                      data.pinnedMessage?.role ?? '',
                                      isSender,
                                    );
                                  },
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: maxWidth,
                                        minWidth: minWidth > maxWidth
                                            ? maxWidth
                                            : minWidth),
                                    child: Container(
                                      padding: AppStyle.paddingAll8,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: isReplySender
                                                      ? const Color(0xff87FF8B)
                                                      : const Color(0xffFF8787),
                                                  width: 2)),
                                          color: kBorder),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isReplySender
                                                ? 'Anda'
                                                : data.pinnedMessage
                                                        ?.receiverName ??
                                                    '',
                                            style: text12HintRegular,
                                          ),
                                          Text(
                                            data.pinnedMessage?.text ??
                                                'No Text',
                                            style: text12HintForm,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(data.pinnedMessage != null ? 6.h : 0),
                              Text(data.text ?? 'No Text',
                                  style: text12BlackRegular),
                            ],
                          ),
                        ),
                      ),
                      Gap(4.hr),
                      // if (isNewDay && index == resultList.length - 1)
                      Text(
                        "${data.createdAt}".formatToHourMinute,
                        // "${data.createdAt}",

                        style: text10HintRegular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget itemHighlightScroll() {
    return Obx(() {
      return Visibility(
        visible: controller.isScroolReply.value &&
            controller.indexScroll.value == index,
        child: Positioned(
          bottom: -8,
          top: -8,
          child: GestureDetector(
            onTap: onTapCancel,
            child: Container(
                width: Get.width.wr,
                decoration: BoxDecoration(
                    color: const Color(0xff333333).withOpacity(0.1))),
          ),
        ),
      );
    });
  }

  Widget itemSelectDelete() {
    return Obx(() {
      return Visibility(
        visible: controller.selectedItemDelete.contains(data),
        child: Positioned(
          bottom: -8,
          top: -8,
          child: GestureDetector(
            onTap: onTapCancel,
            child: Container(
                width: Get.width.wr,
                decoration: BoxDecoration(
                    color: const Color(0xff333333).withOpacity(0.3))),
          ),
        ),
      );
    });
  }

  Widget itemImage() {
    return GestureDetector(
      onLongPress: onLongPress,
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment:
              !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: 8.hr,
                  left: !isSender ? 16.wr : 0,
                  right: isSender ? 16.wr : 0),
              child: CachedNetworkImage(
                  imageUrl: data.image ?? '',
                  imageBuilder: (context, imageProvider) => Column(
                        crossAxisAlignment: isSender
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 120.r,
                            width: 120.r,
                            decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius8All,
                                color: kBorder,
                                border: Border.all(color: kBorder, width: 2),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
                          ),
                          Gap(4.hr),
                          Text(
                            "${data.createdAt}".formatToHourMinute,
                            style: text10HintRegular,
                          )
                        ],
                      ),
                  placeholder: (context, url) => SizedBox(
                        height: 120.r,
                        width: 120.r,
                        child: const Center(
                          child: CupertinoActivityIndicator(color: kSoftBlack),
                        ),
                      ),
                  errorWidget: (context, url, error) => Container(
                        height: 120.r,
                        width: 120.r,
                        decoration: BoxDecoration(
                          borderRadius: AppStyle.borderRadius8All,
                          color: kBorder,
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemProduct() {
    return GestureDetector(
      onLongPress: onLongPress,
      child: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment:
              !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: !isSender ? 16.wr : 0,
                  right: isSender ? 16.wr : 0,
                  bottom: 16.hr),
              child: Container(
                padding: AppStyle.paddingAll8,
                width: Get.width.wr * 0.7,
                decoration: BoxDecoration(
                  borderRadius: AppStyle.borderRadius8All,
                  color: kWhite,
                  border: AppStyle.borderAll,
                ),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: data.pinnedProduct?.image ?? '',
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
                          const CupertinoActivityIndicator(
                        color: kSoftBlack,
                      ),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.pinnedProduct?.name ?? '',
                          style: text12BlackMedium,
                        ),
                        Gap(4.hr),
                        Row(
                          children: [
                            Text(
                              "${data.pinnedProduct?.promo}".toIdrFormat,
                              style: text12BlackRegular,
                            ),
                            Gap(8.wr),
                            Text(
                              "${data.pinnedProduct?.price}".toIdrFormat,
                              style: text10lineThroughRegular,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget deletedItem() {
    return Column(
      crossAxisAlignment:
          !isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: !isSender ? 16.wr : 0, right: isSender ? 16.wr : 0),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                width: Get.width.wr * 0.42,
                padding: AppStyle.paddingAll12,
                decoration: BoxDecoration(
                  borderRadius: AppStyle.borderRadius8All,
                  color: isSender
                      ? const Color(0xffF9F7F7)
                      : const Color(0xffFFE4E2),
                ),
                child: Center(
                    child: Text('Pesan telah dihapus',
                        style: text12HintRegularItalic)),
              ),
              Gap(6.hr),
              Text(
                "${data.createdAt}".formatToHourMinute,
                // "${data.createdAt}",

                style: text10HintRegular,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
