import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../../data/models/product_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';

class TitleProduct extends StatelessWidget {
  final Product product;
  const TitleProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeExtraSmall),
      child: Row(
        children: [
          Expanded(
            child: Text("${product.brand ?? '-'} ${product.model ?? '-'}",
                style: poppinsBoldLarge.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge),
                maxLines: 2),
          ),
          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
          Text(
            '${product.price!}'.priceFormat(),
            style: poppinsBold.copyWith(
                color: ColorResources.red, fontSize: Dimensions.fontSizeLarge),
          ),
        ],
      ),
    );
  }
}
