// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../../data/models/product_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../custom_widgets/rating_bar.dart';
import '../../product/detail_product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProduct(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        height: Dimensions.cardHeight,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).highlightColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: ColorResources.iconBg,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.width / 2.45,
                  image: product.imageProduct!,
                  imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width / 2.45),
                ),
              ),
            ),

            // Product Details
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.paddingSizeSmall,
                  bottom: 2,
                  left: 6,
                  right: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("${product.model ?? '-'} ${product.type ?? '-'}",
                      textAlign: TextAlign.center,
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar(
                      rating: double.parse('${product.rating}'),
                      size: Dimensions.fontSizeSmall,
                    ),
                    SizedBox(width: 1),
                    Text('${product.rating}',
                        style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                        )),
                  ]),
                  const SizedBox(height: 2),
                  Text(
                    '${product.price}'.priceFormat(),
                    style: poppinsRegular.copyWith(color: ColorResources.red),
                  ),
                ],
              ),
            ),
          ]),

          // Off

          const SizedBox.shrink(),
        ]),
      ),
    );
  }
}
