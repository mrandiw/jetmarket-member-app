// ignore_for_file: avoid_print

// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../../utils/global/constant.dart';
import '../../../navigation/routes.dart';

// class DeeplinkService {
//   static Future<String> getInitialLink() async {
//     String? argument;
//     FirebaseDynamicLinks.instance.onLink.listen((event) {
//       final Uri link = event.link;
//       print("Link : $link");
//       print("Params : ${link.queryParameters}");
//       if (link.queryParameters.containsKey('referral')) {
//         deeplinkArgument = {
//           'route': 'register',
//           'referral': link.queryParameters['referral']
//         };
//         Get.offAllNamed(Routes.REGISTER,
//             arguments: link.queryParameters['referral']);
//         argument = link.queryParameters['referral'] ?? '';
//       } else {
//         deeplinkArgument = {
//           'route': 'product',
//           'id': int.parse(link.queryParameters['id'] ?? '')
//         };
//         Get.offAllNamed(Routes.DETAIL_PRODUCT, arguments: [
//           int.parse(link.queryParameters['id'] ?? ''),
//           'from-deeplink'
//         ]);
//         argument = link.queryParameters['id'] ?? '';
//       }
//     }).onError((error) {});
//     return argument ?? '';
//   }

//   static Future<void> getLink() async {
//     final PendingDynamicLinkData? initialLink =
//         await FirebaseDynamicLinks.instance.getInitialLink();

//     if (initialLink != null) {
//       final Uri deepLink = initialLink.link;
//       print("Link init : $deepLink");
//       print("Params init: ${deepLink.queryParameters}");
//       deeplinkArgument = deepLink.queryParameters['referral'] ?? '';
//       if (deepLink.queryParameters.containsKey('referral')) {
//         // Get.offAllNamed(Routes.REGISTER,
//         //     arguments: deepLink.queryParameters['referral']);
//         deeplinkArgument = {
//           'route': 'register',
//           'referral': deepLink.queryParameters['referral']
//         };
//       } else {
//         // Get.offAllNamed(Routes.DETAIL_PRODUCT, arguments: [
//         //   int.parse(deepLink.queryParameters['id'] ?? ''),
//         //   'from-deeplink'
//         // ]);
//         deeplinkArgument = {
//           'route': 'product',
//           'id': int.parse(deepLink.queryParameters['id'] ?? '')
//         };
//       }
//     }
//   }

//   static Future<String> createLink(
//       {required String code, required DeeplinkType type}) async {
//     String? paramsUrl;
//     if (type == DeeplinkType.register) {
//       paramsUrl = "register?referral=$code";
//     } else {
//       paramsUrl = "product?id=$code";
//     }
//     final dynamicLinkParams = DynamicLinkParameters(
//       uriPrefix: "https://jetmarketcustomer.page.link",
//       androidParameters: const AndroidParameters(
//           packageName: "com.jetmarket.customer", minimumVersion: 0),
//       iosParameters: const IOSParameters(
//           bundleId: "com.jetmarket.customer", minimumVersion: '0'),
//       link: Uri.parse("https://jetmarketcustomer.page.link/$paramsUrl"),
//     );

//     final dynamicLink =
//         await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

//     String finalUrl =
//         "${dynamicLink.previewLink?.origin}${dynamicLink.previewLink?.path}";
//     return finalUrl;
//   }
// }


class DeeplinkService {
  static Future<void> handleDeepLink(Uri? link) async {
    if (link == null) {
      print('No deep link detected');
      return;
    }

    print("Deep link detected: $link");
    print("Params: ${link.queryParameters}");

    if (link.queryParameters.containsKey('referral')) {
      final referralCode = link.queryParameters['referral'];
      if (referralCode != null) {
        Get.offAllNamed(Routes.REGISTER, arguments: referralCode);
      }
    } else if (link.queryParameters.containsKey('id')) {
      final productId = int.tryParse(link.queryParameters['id'] ?? '');
      if (productId != null) {
        Get.offAllNamed(Routes.DETAIL_PRODUCT,
            arguments: [productId, 'from-deeplink']);
      }
    } else {
      print('No recognizable parameters in the deep link');
    }
  }

  static void initDeepLinkListener() {
    // Listen for App Links or Universal Links.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uri = Uri.base; // Get the URI when the app is resumed.
      handleDeepLink(uri);
    });
  }

  static String createDeepLink(
      {required String code, required DeeplinkType type}) {
    const String domain = "https://jetmarketcustomer.page.link"; // Your domain
    final String path = (type == DeeplinkType.register)
        ? "/register?referral=$code"
        : "/product?id=$code";

    return '$domain$path';
  }
}

enum DeeplinkType { register, product }
