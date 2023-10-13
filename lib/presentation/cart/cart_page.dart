import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../bloc/checkout/checkout_bloc.dart';
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
        title: Row(children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text('Cart',
              style:
                  poppinsRegular.copyWith(fontSize: 20, color: Colors.black)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
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
                            child: Text("There is no data in the cart"),
                          );
                        }, loaded: (product) {
                          if (product.isEmpty) {
                            return const Center(
                              child: Text("There is no data in the cart"),
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
              child: Center(
                child: Row(
                  children: [
                    Text(
                      'Total Price ',
                      style: poppinsSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault),
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
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeLarge),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  return state.maybeWhen(orElse: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }, loaded: (product) {
                    return product.isEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width / 3.5,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColorLight,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.paddingSizeSmall),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall,
                                    vertical: Dimensions.fontSizeSmall),
                                child: Text('Checkout',
                                    style: poppinsSemiBold.copyWith(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const CheckoutPage();
                              }));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeSmall),
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
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
