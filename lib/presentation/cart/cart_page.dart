import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../bloc/checkout/checkout_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import '../checkout/checkout_page.dart';
import 'widgets/cart_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  List<bool> chooseShipping = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              'Cart',
              style: poppinsRegular.copyWith(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            // const CustomAppBar(title: 'Cart'),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {},
                      child: BlocBuilder<CheckoutBloc, CheckoutState>(
                        builder: (context, state) {
                          return state.maybeWhen(orElse: () {
                            return const Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.remove_shopping_cart_outlined),
                                  Text("No product available in the cart"),
                                ],
                              ),
                            );
                          }, loaded: (product) {
                            if (product.isEmpty) {
                              return const Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_shopping_cart_outlined,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "No product available in the cart",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return ListView.builder(
                              itemCount: product.length,
                              padding: const EdgeInsets.all(0),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: Dimensions.paddingSizeSmall),
                                  child: CartWidget(
                                    productQuantity: product[index],
                                  ),
                                );
                              },
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeLarge,
          vertical: Dimensions.paddingSizeDefault,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price ',
                    style: poppinsRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      return state.maybeWhen(orElse: () {
                        return const CircularProgressIndicator();
                      }, loaded: (product) {
                        int totalPrice = 0;
                        product.forEach(
                          (element) {
                            totalPrice +=
                                element.quantity * element.product.price!;
                          },
                        );
                        return Text(
                          " $totalPrice".priceFormat(),
                          style: poppinsSemiBold.copyWith(
                              color: ColorResources.red,
                              fontSize: Dimensions.fontSizeLarge),
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
            Builder(
              builder: (context) => BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loaded: (product) {
                      return product.isEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 163, 234, 200),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimensions.paddingSizeSmall,
                                      vertical: Dimensions.fontSizeSmall),
                                  child: Text(
                                    'Checkout',
                                    style: poppinsSemiBold.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return CheckoutPage();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      var tween =
                                          Tween(begin: begin, end: end).chain(
                                        CurveTween(curve: curve),
                                      );

                                      var offsetAnimation =
                                          animation.drive(tween);

                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                  ),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 3.5,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeSmall,
                                        vertical: Dimensions.fontSizeSmall),
                                    child: Text(
                                      'Checkout',
                                      style: poppinsSemiBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context).cardColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
