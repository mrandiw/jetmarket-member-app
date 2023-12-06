import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class AtmSection extends StatelessWidget {
  const AtmSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingVert16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          processStep(
            stepTitle: 'STEP 1: FIND NEAREST ATM',
            stepDetails: [
              '1. Insert Your ATM Card',
              '2. Select your preferred language',
              '3. Enter your ATM PIN',
            ],
          ),
          const SizedBox(height: 20.0),
          processStep(
            stepTitle: 'STEP 2: MAKE TRANSACTION',
            stepDetails: [
              '1. Select "Other Transaction"',
              '2. Select "Transfer"',
              '3. Select the type of account you are using to transfer (i.e. from Savings account)',
              '4. Choose "Virtual Account Billing"',
              '5. Enter virtual account number 880887682810',
              '6. The amount billed will show on the screen',
              '7. Confirm the transaction, if it\'s correct then continue',
            ],
          ),
          const SizedBox(height: 20.0),
          processStep(
            stepTitle: 'STEP 3: TRANSACTION COMPLETED',
            stepDetails: [
              '1. Your transaction is completed',
              '2. Once the payment transaction is completed, this invoice will be updated automatically. This may take up to 5 minutes',
            ],
          ),
        ],
      ),
    );
  }

  Widget processStep(
      {required String stepTitle, required List<String> stepDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepTitle,
          style: text12BlackSemiBold,
        ),
        Gap(6.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stepDetails
              .map((detail) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Text(
                      detail,
                      style: text12BlackRegular,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
