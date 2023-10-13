import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/order/order_bloc.dart';
import 'package:flutter_garasi_ev/data/models/request/order_request_model.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../bloc/checkout/checkout_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../payment/payment_page.dart';
import 'widgets/amount.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _shoppingAddress = TextEditingController();
  int subTotalPrice = 0;
  int totalPrice = 0;
  int shippingCost = 0;
  List<Item> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(builder: (context, state) {
        return state.maybeWhen(orElse: () {
          return const CircularProgressIndicator();
        }, loaded: (product) {
          items = product
              .map((e) => Item(id: e.product.id!, quantity: e.quantity))
              .toList();
          product.forEach(
            (element) {
              subTotalPrice += element.quantity * element.product.price!;
            },
          );
          totalPrice = subTotalPrice + shippingCost;
          return ListView(physics: const BouncingScrollPhysics(), children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Text(
                'Shipping Address',
                style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
            ),
            Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: TextField(
                  controller: _shoppingAddress,
                  maxLines: 4,
                  decoration: const InputDecoration(
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeDefault),
              child: Text(
                'Order Detail',
                style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: product.length,
                itemBuilder: (ctx, index) {
                  final listProduct = product[index];
                  return Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: .5,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.25)),
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraExtraSmall),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeExtraExtraSmall),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            image: listProduct.product.imageProduct!,
                            imageErrorBuilder: (c, o, s) => Image.asset(
                                Images.placeholder,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50),
                          ),
                        ),
                      ),
                      const SizedBox(width: Dimensions.marginSizeDefault),
                      Expanded(
                        flex: 3,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${listProduct.product.model} ${listProduct.product.type}",
                                      style: poppinsRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                          color:
                                              ColorResources.primaryMaterial),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Text(
                                    '${listProduct.product.price! * listProduct.quantity}'
                                        .priceFormat(),
                                    style: poppinsSemiBold.copyWith(
                                        fontSize: Dimensions.fontSizeLarge),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: Dimensions.marginSizeExtraSmall),
                              Row(children: [
                                Text('Qty -  ${listProduct.quantity}',
                                    style: poppinsRegular.copyWith()),
                              ]),
                            ]),
                      ),
                    ]),
                  );
                }),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(.055),
              ),
              child: Center(
                  child: Text(
                'Order Summary',
                style: poppinsSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge),
              )),
            ),
            // Total bill
            Container(
              margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              color: Theme.of(context).highlightColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AmountWidget(
                      title: 'Sub Total :',
                      amount: '$subTotalPrice'.priceFormat(),
                    ),
                    AmountWidget(
                        title: 'Shipping Cost: ',
                        amount: '$shippingCost'.priceFormat()),
                    Divider(height: 5, color: Theme.of(context).hintColor),
                    AmountWidget(
                      title: 'Total :',
                      amount: '$totalPrice'.priceFormat(),
                    ),
                  ]),
            ),
          ]);
        });
      }),
      bottomNavigationBar: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          state.maybeWhen(
              orElse: () {},
              loaded: (data) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PaymentPage(url: data.data.paymentUrl);
                }));
              });
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return InkWell(
                onTap: () {
                  final requestModel = OrderRequestModel(
                      items: items,
                      totalPrice: totalPrice,
                      deliveryAddress: _shoppingAddress.text,
                      sellerId: 3);
                  context.read<OrderBloc>().add(OrderEvent.order(requestModel));
                  context.read<CheckoutBloc>().add(const CheckoutEvent.clear());
                },
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge,
                      vertical: Dimensions.paddingSizeDefault),
                  decoration: const BoxDecoration(
                      color: ColorResources.primaryMaterial),
                  child: Center(
                      child: Builder(
                    builder: (context) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 2.9),
                      child: Text('Proceed',
                          style: poppinsSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Theme.of(context).cardColor,
                          )),
                    ),
                  )),
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            // error: (message) {
            //   return Text(message);
            // },
          );
        },
      ),
    );
  }
}

// class PaymentButton extends StatelessWidget {
//   final String image;
//   final Function? onTap;
//   const PaymentButton({Key? key, required this.image, this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap as void Function()?,
//       child: Container(
//         height: 45,
//         margin: const EdgeInsets.symmetric(
//             horizontal: Dimensions.paddingSizeExtraSmall),
//         padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           border: Border.all(width: 2, color: ColorResources.grey),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Image.asset(image),
//       ),
//     );
//   }
// }

// class PaymentMethod {
//   String name;
//   String image;
//   PaymentMethod(this.name, this.image);
// }
