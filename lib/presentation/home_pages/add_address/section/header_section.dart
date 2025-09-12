import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/home_pages/add_address/controllers/add_address.controller.dart';
import 'package:jetmarket/presentation/home_pages/location/section/common_form.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddAddressController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => CommonForm(
                label: 'Label Alamat',
                formKey: controller.labelAddressFormKey,
                autovalidateMode: controller.autoValidateLabelAddress,
                textEditingController: controller.labelAddressController,
                maxLines: 1,
                hint: 'Contoh: Rumah Ibu',
                onChanged: (query) {},
                readOnly: controller.readOnly.value,
              ),
            ),
            Gap(8.h),
            Obx(
              () => CommonForm(
                label: 'Alamat',
                formKey: controller.recipientAddressFormKey,
                autovalidateMode: controller.autoValidateRecipientAddress,
                textEditingController: controller.recipientAddressController,
                maxLines: 3,
                hint:
                    'Masukan alamat desa kec kota. Contoh: sukamelang baleendah bandung',
                onChanged: (query) {},
                readOnly: controller.readOnly.value,
              ),
            ),
            Gap(8.h),
            Obx(
              () => controller.readOnly.value
                  ? Row(
                      children: [
                        Expanded(
                          child: AppButton.secondary(
                            text: "Ubah",
                            onPressed: () {
                              controller.readOnly.value = false;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: AppButton.primary(
                            text: "Lanjut",
                            onPressed: () {
                              Get.toNamed(
                                Routes.DETAIL_ADDRESS,
                                arguments: controller.locationData.toJson(),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : AppButton.primary(
                      text: "Cek Lokasi",
                      onPressed: () {
                        controller.getDataLocation();
                      },
                    ),
            )
          ],
        ),
      );
    });
  }
}
