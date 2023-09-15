import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';

import '../../../utils/dimensions.dart';

class SpesificationProduct extends StatelessWidget {
  final String spesificationProduct;
  const SpesificationProduct({Key? key, required this.spesificationProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Spesification",
          style: titleHeader,
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        spesificationProduct.isNotEmpty
            ? Expanded(child: Text(spesificationProduct))
            : const Center(
                child: Text('No specification'),
              ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
      ],
    );
  }
}
