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

class CardItem extends StatelessWidget {
  final Product product;
  const CardItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return DetailProduct(
                product: product,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      },
      child: Container(
        height: 210,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
              height: 126,
              decoration: BoxDecoration(
                color: ColorResources.iconBg,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${product.brand ?? '-'} ${product.model ?? '-'}",
                      textAlign: TextAlign.center,
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 1),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    RatingBar(
                      rating: double.parse('${product.rating}'),
                      size: Dimensions.fontSizeSmall,
                    ),
                    SizedBox(width: 1),
                    Text(
                      '${product.rating}',
                      style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                      ),
                    ),
                  ]),
                  const SizedBox(height: 1),
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
