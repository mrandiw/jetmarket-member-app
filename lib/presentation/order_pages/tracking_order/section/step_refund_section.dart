import 'package:flutter/material.dart';

import '../widget/custom_step_refund.dart';

class StepRefundSection extends StatelessWidget {
  const StepRefundSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomStepperRefund(currentStep: 1);
  }
}
