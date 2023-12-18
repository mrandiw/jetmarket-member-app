import 'package:flutter/widgets.dart';

class VaPayment extends StatelessWidget {
  const VaPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [Text('Bank Mandiri')],
        )
      ],
    );
  }
}
