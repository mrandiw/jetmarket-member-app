import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import '../../../../utils/global/constant.dart';

class DeeplinkService {
  static Future<String> getInitialLink() async {
    String? argument;
    FirebaseDynamicLinks.instance.onLink.listen((event) {
      final Uri link = event.link;
      log("Link : $link");
      log("Params : ${link.queryParameters['referral']}");
      // if (link.queryParameters['referral'] != null) {
      //   Get.offAllNamed(Routes.REGISTER,
      //       arguments: link.queryParameters['referral']);
      // }
      argument = link.queryParameters['referral'] ?? '';
    }).onError((error) {});
    return argument ?? '';
  }

  static Future<String?> getLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      log("Link : $deepLink");
      log("Params : ${deepLink.queryParameters['referral']}");
      deeplinkArgument = deepLink.queryParameters['referral'] ?? '';
      return deepLink.queryParameters['referral'];
    } else {
      return null;
    }
  }

  static Future<String> createLink({required String code}) async {
    final dynamicLinkParams = DynamicLinkParameters(
      uriPrefix: "https://jetmarketcustomer.page.link",
      androidParameters: const AndroidParameters(
          packageName: "com.jetmarket.customer", minimumVersion: 0),
      iosParameters: const IOSParameters(
          bundleId: "com.jetmarket.customer", minimumVersion: '0'),
      link: Uri.parse(
          "https://jetmarketcustomer.page.link/register?referral=$code"),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    String finalUrl =
        "${dynamicLink.previewLink?.origin}${dynamicLink.previewLink?.path}";
    return finalUrl;
  }
}
