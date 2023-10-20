import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/presentation/checkout/checkout_page.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../bloc/checkout/checkout_bloc.dart';
import '../../../data/models/product_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../custom_widgets/button/custom_button.dart';
import 'add_product_snackbar.dart';

class BuyNowBottomSheet extends StatefulWidget {
  final Function? callback; //biar quantity yg diatas cart muncul
  final Product product;
  const BuyNowBottomSheet({
    Key? key,
    this.callback,
    required this.product,
  }) : super(key: key);

  @override
  BuyNowBottomSheetState createState() => BuyNowBottomSheetState();
}

class BuyNowBottomSheetState extends State<BuyNowBottomSheet> {
  // route(bool isRoute, String message) async {}
  int quantity = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).highlightColor,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).hintColor,
                              spreadRadius: 1,
                              blurRadius: 5,
                            )
                          ]),
                      child: const Icon(Icons.clear,
                          size: Dimensions.iconSizeSmall),
                    ),
                  )),
              Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: ColorResources.imageBg,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: .5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.20),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder,
                              image: widget.product.imageProduct!,
                              imageErrorBuilder: (c, o, s) =>
                                  Image.asset(Images.placeholder),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${widget.product.model ?? '-'} ${widget.product.type ?? '-'}",
                                    style: poppinsRegular.copyWith(
                                        fontSize: Dimensions.fontSizeLarge),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                const SizedBox(
                                    height: Dimensions.paddingSizeSmall),
                                // Row(
                                //   children: [
                                //     const Icon(Icons.star,
                                //         color: Colors.orange),
                                //     Text(double.parse('5').toStringAsFixed(1),
                                //         style: poppinsSemiBold.copyWith(
                                //             fontSize: Dimensions.fontSizeLarge),
                                //         maxLines: 2,
                                //         overflow: TextOverflow.ellipsis),
                                //   ],
                                // ),
                                Text(
                                  '${widget.product.price}'.priceFormat(),
                                  style: poppinsRegular.copyWith(
                                      color: ColorResources.red,
                                      fontSize: Dimensions.fontSizeExtraLarge),
                                ),
                              ]),
                        ),
                      ]),
                ],
              ),
              const SizedBox(
                height: Dimensions.paddingSizeSmall,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Quantity',
                    style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              if (quantity > 1) {
                                quantity -= 1;
                              }
                            },
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            color: ColorResources.primaryMaterial,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9),
                          child: const Icon(
                            Icons.remove,
                            size: 16,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorResources.primaryMaterial,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          '$quantity',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            quantity += 1;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 9),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: ColorResources.primaryMaterial,
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 16,
                            color: ColorResources.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),

              // const SizedBox(height: Dimensions.paddingSizeSmall),
              // Divider(
              //   thickness: 1,
              //   color: ColorResources.black,
              // ),
              // const SizedBox(height: Dimensions.paddingSizeSmall),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Total Price',
              //       style: poppinsRegular.copyWith(
              //           color: ColorResources.black,
              //           fontSize: Dimensions.fontSizeExtraLarge),
              //     ),
              //     const SizedBox(width: Dimensions.paddingSizeSmall),
              //     Text(
              //       '${widget.product.price! * quantity}'.priceFormat(),
              //       style: poppinsRegular.copyWith(
              //           color: ColorResources.red,
              //           fontSize: Dimensions.fontSizeExtraLarge),
              //     ),
              //   ],
              // ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Divider(
                thickness: 1,
                color: ColorResources.black,
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isBuy: true,
                      buttonText: 'Buy Now',
                      onTap: () {
                        context.read<CheckoutBloc>().add(
                              CheckoutEvent.addToCart(widget.product, quantity),
                            );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckoutPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void _navigateToNextScreen(BuildContext context) {}
}

class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int? quantity;
  final bool isCartWidget;
  final int? stock;
  final int? minimumOrderQuantity;
  final bool digitalProduct;

  const QuantityButton({
    Key? key,
    required this.isIncrement,
    required this.quantity,
    required this.stock,
    this.isCartWidget = false,
    required this.minimumOrderQuantity,
    required this.digitalProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (!isIncrement && quantity! > 1) {
          if (quantity! > minimumOrderQuantity!) {
          } else {
            Fluttertoast.showToast(
                msg: 'minimum qty 1',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else if (isIncrement && quantity! < stock! || digitalProduct) {}
      },
      icon: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(width: 1, color: Theme.of(context).primaryColor)),
        child: Icon(
          isIncrement ? Icons.add : Icons.remove,
          color: isIncrement
              ? quantity! >= stock! && !digitalProduct
                  ? ColorResources.lowGreen
                  : ColorResources.primaryMaterial
              : quantity! > 1
                  ? ColorResources.primaryMaterial
                  : ColorResources.hintTextColor,
          size: isCartWidget ? 26 : 20,
        ),
      ),
    );
  }
}
