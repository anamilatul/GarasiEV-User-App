import 'package:flutter/material.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';

class AmountWidget extends StatelessWidget {
  final String? title;
  final String amount;

  const AmountWidget({Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title!,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
        Text(amount,
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),
      ]),
    );
  }
}
