import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Visibility(
          visible: controller.searchActived == false &&
              controller.banners.isNotEmpty,
          child: CarouselSlider(
            items: controller.banners.map((data) {
              return GestureDetector(
                child: CachedNetworkImage(
                  imageUrl: Uri.tryParse(data.image ?? '')?.isAbsolute == true
                      ? data.image ?? ''
                      : '',
                  height: 120.w,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: 120.w,
                      decoration: BoxDecoration(
                          color: kSofterGrey,
                          borderRadius: AppStyle.borderRadius8All,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)),
                    );
                  },
                  placeholder: (context, url) =>
                      const Center(child: CupertinoActivityIndicator()),
                  errorWidget: (context, url, error) {
                    return Container(
                      height: 120.w,
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        color: kSofterGrey,
                        borderRadius: AppStyle.borderRadius8All,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: kPrimaryColor,
                          size: 18.r,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: 5.seconds,
              enlargeCenterPage: true,
              aspectRatio: 16 / 6,
              onPageChanged: (index, reason) {
                // controller.chengeSlider(index);
              },
            ),
          ),
        );
      }),
    );
  }
}
