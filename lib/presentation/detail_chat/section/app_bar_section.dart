import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/detail_chat/controllers/detail_chat.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

class AppBarDetailChat extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDetailChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailChatController>(builder: (controller) {
      return AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset(arrowForward),
        ),
        title: Row(
          children: [
            CachedNetworkImage(
                imageUrl: controller.seller?.avatar ?? '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 26.r,
                      backgroundColor: kPrimaryColor2,
                      backgroundImage: imageProvider,
                    ),
                placeholder: (context, url) => SizedBox(
                      height: 72.r,
                      width: 72.r,
                      child: const Center(
                        child: CupertinoActivityIndicator(color: kSoftBlack),
                      ),
                    ),
                errorWidget: (context, url, error) => CircleAvatar(
                      radius: 26.r,
                      backgroundColor: kPrimaryColor2,
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: kPrimaryColor,
                          size: 20.r,
                        ),
                      ),
                    )),
            Gap(6.wr),
            Text(controller.seller?.name ?? '', style: text16BlackSemiBold),
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
