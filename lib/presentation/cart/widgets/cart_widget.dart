// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/checkout/checkout_bloc.dart';
import 'package:flutter_garasi_ev/presentation/product/detail_product.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';

class CartWidget extends StatefulWidget {
  final ProductQuantity productQuantity;
  const CartWidget({
    Key? key,
    required this.productQuantity,
  }) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int quantity = 1;

  @override
  void initState() {
    quantity = widget.productQuantity.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context,
        //     PageRouteBuilder(
        //       transitionDuration: const Duration(milliseconds: 1000),
        //       pageBuilder: (context, anim1, anim2) =>  DetailProduct(),
        //     ));
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(.20),
                        width: 1),
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      height: 100,
                      // width: 60,
                      image: widget.productQuantity.product.imageProduct!,
                      imageErrorBuilder: (c, o, s) => Image.asset(
                        Images.placeholder,
                        fit: BoxFit.cover,
                        height: 100,
                        // width: 60,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.productQuantity.product.model} ${widget.productQuantity.product.type} ",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: poppinsBold.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: Dimensions.paddingSizeSmall,
                            ),
                            InkWell(
                              onTap: () {
                                // context.read<CheckoutBloc>().add(
                                //       CheckoutEvent.removeProductInCart(
                                //           productQuantity.product,
                                //           productQuantity.quantity),
                                //     );

                                showModalBottomSheet<void>(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(
                                                        Icons.arrow_back)),
                                                Text(
                                                  'Confirmation',
                                                  style: poppinsRegularLarge,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: Text(
                                                'Do you want to remove "${widget.productQuantity.product.model} ${widget.productQuantity.product.type}" ?',
                                                style: poppinsRegularLarge,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          ColorResources.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        side: const BorderSide(
                                                            color: ColorResources
                                                                .primaryMaterial),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'No',
                                                      style: poppinsRegular,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read<CheckoutBloc>()
                                                          .add(
                                                            CheckoutEvent.removeProductInCart(
                                                                widget
                                                                    .productQuantity
                                                                    .product,
                                                                widget
                                                                    .productQuantity
                                                                    .quantity),
                                                          );
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          ColorResources.green,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'Yes',
                                                      style: poppinsRegular,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "${widget.productQuantity.product.price}"
                                  .priceFormat(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: poppinsRegular.copyWith(
                                  color: ColorResources.red,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              " x ${widget.productQuantity.quantity}",
                              style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              thickness: 2,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
