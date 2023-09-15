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
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                  child: Text("${product.model ?? '-'} ${product.type ?? '-'}",
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                      maxLines: 2)),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              Column(
                children: [
                  Text(
                    '${product.price!}'.priceFormat(),
                    style: poppinsBold.copyWith(
                        color: ColorResources.primaryMaterial,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                ],
              ),
            ]),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],
        ));
  }
}
