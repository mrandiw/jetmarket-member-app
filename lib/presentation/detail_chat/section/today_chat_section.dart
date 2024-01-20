// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:jetmarket/utils/extension/currency.dart';
// import 'package:jetmarket/utils/extension/date_format.dart';
// import 'package:jetmarket/utils/extension/responsive_size.dart';

// import '../../../infrastructure/theme/app_colors.dart';
// import '../../../infrastructure/theme/app_text.dart';
// import '../../../utils/app_preference/app_preferences.dart';
// import '../../../utils/style/app_style.dart';
// import '../controllers/detail_chat.controller.dart';

// class TodayChat extends StatelessWidget {
//   const TodayChat({
//     super.key,
//     required this.controller,
//   });

//   final DetailChatController controller;

//   @override
//   Widget build(BuildContext context) {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 72.hr),
//         child: StreamBuilder<Map<String, dynamic>>(
//           stream: controller.getMessages('2#1#1'),
//           builder: (context, snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             final data = snapshot.data;
//             String? firstKey;
//             if (data != null && data.isNotEmpty) {
//               firstKey = data.keys.first;
//             }

//             List<Map<String, dynamic>> resultList;
//             if (firstKey != null) {
//               resultList = data?[firstKey]!.cast<Map<String, dynamic>>() ?? [];
//             } else {
//               // Jika firstKey null, berikan nilai default berupa list kosong
//               resultList = [];
//             }

//             if (resultList.isEmpty) {
//               return const Center(
//                 child: Text("Belum ada chat"),
//               );
//             }

//             return ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: AppStyle.paddingAll16,
//               itemCount: resultList.length,
//               itemBuilder: (context, index) {
//                 bool isSender = resultList[index]['from_id'] ==
//                     AppPreference().getUserData()?.user?.id;
//                 return Padding(
//                   padding: AppStyle.paddingBottom12,
//                   child: Column(
//                     crossAxisAlignment: isSender
//                         ? CrossAxisAlignment.end
//                         : CrossAxisAlignment.start,
//                     children: [
//                       if (index == 0)
//                         Center(
//                             child: Padding(
//                           padding: AppStyle.paddingBottom12,
//                           child: Text(
//                             'Today',
//                             style: text12BlackRegular,
//                           ),
//                         )),
//                       Visibility(
//                         visible: resultList[index]['pinned_product'] != null,
//                         child: Padding(
//                           padding: AppStyle.paddingBottom8,
//                           child: Container(
//                             padding: AppStyle.paddingAll8,
//                             width: Get.width.wr * 0.7,
//                             decoration: BoxDecoration(
//                               borderRadius: AppStyle.borderRadius8All,
//                               color: kWhite,
//                               border: AppStyle.borderAll,
//                             ),
//                             child: Row(
//                               children: [
//                                 CachedNetworkImage(
//                                   imageUrl: resultList[index]['pinned_product']
//                                           ?['image'] ??
//                                       '',
//                                   imageBuilder: (context, imageProvider) =>
//                                       Container(
//                                     height: 50.h,
//                                     width: 50.h,
//                                     decoration: BoxDecoration(
//                                       color: kSofterGrey,
//                                       borderRadius: AppStyle.borderRadius8All,
//                                       image: DecorationImage(
//                                         image: imageProvider,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                   placeholder: (context, url) =>
//                                       const CupertinoActivityIndicator(
//                                     color: kSoftBlack,
//                                   ),
//                                   errorWidget: (context, url, error) =>
//                                       Container(
//                                     height: 50.h,
//                                     width: 50.h,
//                                     decoration: BoxDecoration(
//                                       color: kSofterGrey,
//                                       borderRadius: AppStyle.borderRadius6All,
//                                     ),
//                                     child: Center(
//                                       child: Icon(
//                                         Icons.error,
//                                         color: kPrimaryColor,
//                                         size: 18.r,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Gap(8.wr),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       resultList[index]['pinned_product']
//                                               ?['name'] ??
//                                           '',
//                                       style: text12BlackMedium,
//                                     ),
//                                     Gap(4.hr),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "${resultList[index]['pinned_product']?['promo']}"
//                                                   .toIdrFormat ??
//                                               '',
//                                           style: text12BlackRegular,
//                                         ),
//                                         Gap(8.wr),
//                                         Text(
//                                           "${resultList[index]['pinned_product']?['price']}"
//                                                   .toIdrFormat ??
//                                               '',
//                                           style: text10lineThroughRegular,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                           visible: resultList[index]['image'] != null,
//                           child: Padding(
//                             padding: AppStyle.paddingBottom8,
//                             child: CachedNetworkImage(
//                                 imageUrl: resultList[index]['image'] ?? '',
//                                 imageBuilder: (context, imageProvider) =>
//                                     Column(
//                                       crossAxisAlignment: isSender
//                                           ? CrossAxisAlignment.start
//                                           : CrossAxisAlignment.end,
//                                       children: [
//                                         Container(
//                                           height: 120.r,
//                                           width: 120.r,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   AppStyle.borderRadius8All,
//                                               color: kBorder,
//                                               image: DecorationImage(
//                                                   image: imageProvider,
//                                                   fit: BoxFit.cover)),
//                                         ),
//                                         Gap(4.hr),
//                                         Text(
//                                           "${resultList[index]['created_at']}"
//                                               .formatToHourMinute,
//                                           style: text10HintRegular,
//                                         )
//                                       ],
//                                     ),
//                                 placeholder: (context, url) => SizedBox(
//                                       height: 120.r,
//                                       width: 120.r,
//                                       child: const Center(
//                                         child: CupertinoActivityIndicator(
//                                             color: kSoftBlack),
//                                       ),
//                                     ),
//                                 errorWidget: (context, url, error) => Container(
//                                       height: 120.r,
//                                       width: 120.r,
//                                       decoration: BoxDecoration(
//                                         borderRadius: AppStyle.borderRadius8All,
//                                         color: kBorder,
//                                       ),
//                                     )),
//                           )),
//                       Visibility(
//                         visible: resultList[index]['text'] != null &&
//                             resultList[index]['text'] != '',
//                         child: SizedBox(
//                           child: Column(
//                             crossAxisAlignment: isSender
//                                 ? CrossAxisAlignment.start
//                                 : CrossAxisAlignment.end,
//                             children: [
//                               GestureDetector(
//                                 onLongPress: () {
//                                   // controller.selectMessage({
//                                   //   'id': resultList[index]['id'],
//                                   //   'message': resultList[index]['text']
//                                   // });
//                                 },
//                                 child: ConstrainedBox(
//                                   constraints: BoxConstraints(
//                                       maxWidth: Get.width.wr * 0.8),
//                                   child: Container(
//                                     padding: AppStyle.paddingAll12,
//                                     decoration: BoxDecoration(
//                                         borderRadius: AppStyle.borderRadius8All,
//                                         color: isSender
//                                             ? const Color(0xffF9F7F7)
//                                             : const Color(0xffFFE4E2)),
//                                     child: Text(
//                                         resultList[index]['text'] ?? 'No Text',
//                                         style: text12BlackRegular),
//                                   ),
//                                 ),
//                               ),
//                               Gap(4.hr),
//                               // if (isNewDay && index == resultList.length - 1)
//                               Text(
//                                 "${resultList[index]['created_at']}"
//                                     .formatToHourMinute,
//                                 style: text10HintRegular,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
