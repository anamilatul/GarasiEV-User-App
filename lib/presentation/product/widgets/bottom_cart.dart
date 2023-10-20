import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/presentation/custom_widgets/custom_snackbar.dart';
import '../../../bloc/checkout/checkout_bloc.dart';
import '../../../data/models/product_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';
import '../../cart/cart_page.dart';
import '../../checkout/checkout_page.dart';
import 'buy_now_bottom_sheet.dart';
import 'cart_bottom_sheet.dart';
import '../../custom_widgets/button/custom_button.dart';

class BottomCart extends StatefulWidget {
  final Product product;
  const BottomCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<BottomCart> createState() => _BottomCartState();
}

class _BottomCartState extends State<BottomCart> {
  bool vacationIsOn = false;
  bool temporaryClose = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).hintColor,
              blurRadius: .5,
              spreadRadius: .1)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (vacationIsOn || temporaryClose) {
                } else {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0),
                    builder: (con) => CartBottomSheet(
                      product: widget.product,
                      callback: () {
                        customSnackBar('', context, isError: false);
                      },
                    ),
                  );
                }
              },
              child: const Icon(
                Icons.add_shopping_cart_outlined,
                color: ColorResources.black,
                size: 40,
              ),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Padding(
          //     padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          //     child: Stack(
          //       children: [
          //         GestureDetector(
          //           onTap: () {

          //             Navigator.of(context).push(MaterialPageRoute(
          //                 builder: (context) => const CartPage()));
          //           },
          //           child: const Icon(
          //             Icons.shopping_bag_outlined,
          //             color: ColorResources.black,
          //             size: 40,
          //           ),
          //         ),
          //         Positioned(
          //           top: 0,
          //           right: 25,
          //           child: Container(
          //             height: 17,
          //             width: 17,
          //             alignment: Alignment.center,
          //             decoration: const BoxDecoration(
          //               shape: BoxShape.circle,
          //               color: ColorResources.red,
          //             ),
          //             child: BlocBuilder<CheckoutBloc, CheckoutState>(
          //               builder: (context, state) {
          //                 return state.map(loading: (value) {
          //                   return const CircularProgressIndicator();
          //                 }, loaded: (value) {
          //                   int totalQuantity = 0;
          //                   value.product.forEach(
          //                     (element) {
          //                       totalQuantity += element.quantity;
          //                     },
          //                   );
          //                   // for (var element in value.product) {
          //                   //   totalQuantity += element.quantity;
          //                   // }
          //                   return Text(
          //                     '$totalQuantity',
          //                     style: poppinsSemiBold.copyWith(
          //                         fontSize: Dimensions.fontSizeExtraSmall,
          //                         color: Theme.of(context).highlightColor),
          //                   );
          //                 });
          //               },
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            flex: 11,
            child: InkWell(
              onTap: () {
                // context.read<CheckoutBloc>().add(
                //       CheckoutEvent.addToCart(widget.product, 1),
                //     );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => CheckoutPage(),
                //   ),
                // );

                if (vacationIsOn || temporaryClose) {
                } else {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0),
                    builder: (con) => BuyNowBottomSheet(
                      product: widget.product,
                      callback: () {
                        customSnackBar('', context, isError: false);
                      },
                    ),
                  );
                }
              },
              child: Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: ColorResources.primaryMaterial,
                ),
                child: Text(
                  'Buy Now',
                  style: poppinsSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).highlightColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
