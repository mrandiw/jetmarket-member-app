import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import '../../../../utils/global/constant.dart';
import '../../../navigation/routes.dart';

class DeeplinkService {
  static Future<String> getInitialLink() async {
    String? argument;
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      final Uri link = event.link;
      log("Link : $link");
      log("Params : ${link.queryParameters}");
      if (link.queryParameters.containsKey('referral')) {
        Get.offAllNamed(Routes.REGISTER,
            arguments: link.queryParameters['referral']);
        argument = link.queryParameters['referral'] ?? '';
      } else {
        Get.offAllNamed(Routes.DETAIL_PRODUCT, arguments: [
          int.parse(link.queryParameters['id'] ?? ''),
          'from-deeplink'
        ]);
        argument = link.queryParameters['id'] ?? '';
      }
    }).onError((error) {});
    return argument ?? '';
  }

  static Future<String?> getLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      log("Link : $deepLink");
      log("Params : ${deepLink.queryParameters}");
      deeplinkArgument = deepLink.queryParameters['referral'] ?? '';
      return deepLink.queryParameters['referral'];
    } else {
      return null;
    }
  }

  static Future<String> createLink(
      {required String code, required DeeplinkType type}) async {
    String? paramsUrl;
    if (type == DeeplinkType.register) {
      paramsUrl = "register?referral=$code";
    } else {
      paramsUrl = "product?id=$code";
    }
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: "https://jetmarketcustomer.page.link",
      androidParameters: const AndroidParameters(
          packageName: "com.jetmarket.customer", minimumVersion: 0),
      iosParameters: const IOSParameters(
          bundleId: "com.jetmarket.customer", minimumVersion: '0'),
      link: Uri.parse("https://jetmarketcustomer.page.link/$paramsUrl"),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    String finalUrl =
        "${dynamicLink.previewLink?.origin}${dynamicLink.previewLink?.path}";
    return finalUrl;
  }
}

enum DeeplinkType { register, product }
