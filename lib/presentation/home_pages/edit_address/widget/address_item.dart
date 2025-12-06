import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jetmarket/domain/core/model/model_data/address_model.dart';
import 'package:jetmarket/presentation/home_pages/edit_address/controllers/edit_address.controller.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({super.key, required this.data, required this.index});
  final AddressModel data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAddressController>(builder: (controller) {
      return GestureDetector(
        onTap: () => controller.selectAddress(index),
        child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: AppStyle.borderRadius8All,
                side: AppStyle.borderSide),
            color: controller.selectedAddress == index
                ? kNormalAccentColor2
                : kWhite,
            child: Padding(
              padding: AppStyle.paddingAll12,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data.label ?? '', style: text12BlackSemiBold),
                          Gap(8.w),
                          Visibility(
                            visible: data.isMain ?? false,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                    color: kPrimaryColor2,
                                    borderRadius: AppStyle.borderRadius6All),
                                child:
                                    Text('Utama', style: text12PrimaryRegular)),
                          ),
                        ],
                      ),
                      Text(data.personName ?? '', style: text12BlackSemiBold),
                      Gap(4.h),
                      Text(data.personPhone ?? '', style: text12HintRegular),
                      Gap(4.h),
                      Text(data.address ?? '', style: text12HintRegular),
                      Gap(8.h),
                      // Map preview for addresses with coordinates
                      if (data.lat != null && data.lng != null)
                        Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius6All,
                            border: Border.all(color: kSoftGrey),
                          ),
                          child: ClipRRect(
                            borderRadius: AppStyle.borderRadius6All,
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(data.lat!, data.lng!),
                                zoom: 15,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId('address_${data.id}'),
                                  position: LatLng(data.lat!, data.lng!),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRed,
                                  ),
                                  infoWindow: InfoWindow(
                                    title: data.label ?? 'Alamat',
                                    snippet: data.address,
                                  ),
                                ),
                              },
                              zoomControlsEnabled: false,
                              myLocationEnabled: false,
                              myLocationButtonEnabled: false,
                              mapToolbarEnabled: false,
                              scrollGesturesEnabled: false,
                              zoomGesturesEnabled: false,
                              rotateGesturesEnabled: false,
                              tiltGesturesEnabled: false,
                              compassEnabled: false,
                              mapType: MapType.normal,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                        onTap: () => controller.editAddress(data),
                        child: Text(
                          'Ubah',
                          style: text11NormalMedium,
                        )),
                    Gap(8.h),
                    SizedBox(
                      width: 8.r,
                      height: 8.r,
                      child: Transform.scale(
                        scale: 0.7,
                        child: RadioListTile(
                            activeColor: kPrimaryColor,
                            fillColor: WidgetStateProperty.all(
                                controller.selectedAddress == index
                                    ? kPrimaryColor
                                    : kDivider),
                            value: index,
                            selected: controller.selectedAddress == index,
                            groupValue: controller.selectedAddress,
                            onChanged: (value) =>
                                controller.selectAddress(value!)),
                      ),
                    ),
                  ],
                ),
              ]),
            )),
      );
    });
  }
}
