// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_garasi_ev/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';

class CartWidget extends StatelessWidget {
  final ProductQuantity productQuantity;
  const CartWidget({
    Key? key,
    required this.productQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //       transitionDuration: const Duration(milliseconds: 1000),
        //       pageBuilder: (context, anim1, anim2) => const ProductDetail(),
        //     ));
      },
      child: Container(
        margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(.20),
                        width: 1)),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  child: FadeInImage.assetNetwork(
                    placeholder: Images.placeholder,
                    height: 60,
                    width: 60,
                    image: productQuantity.product.imageProduct!,
                    imageErrorBuilder: (c, o, s) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeExtraSmall),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${productQuantity.product.model} ${productQuantity.product.type} ",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: poppinsBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeSmall,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CheckoutBloc>().add(
                                  CheckoutEvent.removeProductInCart(
                                      productQuantity.product,
                                      productQuantity.quantity));
                            },
                            child: const Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Row(
                        children: [
                          Text(
                            "${productQuantity.product.price}".priceFormat(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: poppinsRegular.copyWith(
                                color: ColorResources.primaryMaterial,
                                fontSize: Dimensions.fontSizeExtraLarge),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(" x ${productQuantity.quantity}")
                        ],
                      ),
                      // const SizedBox(width: Dimensions.paddingSizeSmall),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
