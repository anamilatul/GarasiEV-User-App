import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/bloc/order/order_bloc.dart';
import 'package:flutter_garasi_ev/data/models/request/order_request_model.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';
import '../../bloc/checkout/checkout_bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
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
              'Checkout',
              style: poppinsRegular.copyWith(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const CircularProgressIndicator();
            },
            loaded: (product) {
              items = product
                  .map((e) => Item(id: e.product.id!, quantity: e.quantity))
                  .toList();
              product.forEach(
                (element) {
                  subTotalPrice += element.quantity * element.product.price!;
                },
              );
              totalPrice = subTotalPrice + shippingCost;
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return state.when(
                              initial: () {
                                context
                                    .read<ProfileBloc>()
                                    .add(const ProfileEvent.getProfile());
                                return Container(
                                  // margin: EdgeInsets.all(10),
                                  // decoration: BoxDecoration(
                                  //   color: const Color.fromARGB(
                                  //       255, 249, 245, 245),
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   border: Border.all(
                                  //     color: const Color.fromARGB(
                                  //         255, 215, 215, 215),
                                  //   ),
                                  // ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text("Nama"),
                                        subtitle: Text("-"),
                                      ),
                                      ListTile(
                                        title: Text("Nomor Handphone"),
                                        subtitle: Text("-"),
                                      ),
                                      Divider(
                                        indent: 10,
                                        endIndent: 10,
                                        thickness: 2,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              loading: () => Center(
                                child: CircularProgressIndicator(),
                              ),
                              error: (message) {
                                return Text(message);
                              },
                              loaded: (profile) {
                                return Container(
                                  // margin: EdgeInsets.all(10),
                                  // decoration: BoxDecoration(
                                  //   color: const Color.fromARGB(
                                  //       255, 249, 245, 245),
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   border: Border.all(
                                  //     color: const Color.fromARGB(
                                  //         255, 215, 215, 215),
                                  //   ),
                                  // ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            color: ColorResources.red,
                                          ),
                                          Text(
                                            'Shipping Address',
                                            style: poppinsBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 21),
                                        child: Row(
                                          children: [
                                            Text(
                                              profile.name,
                                              style:
                                                  poppinsRegularLarge.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeLarge),
                                            ),
                                            Text(" | "),
                                            Text(
                                              profile.phone ?? "-",
                                              style:
                                                  poppinsRegularLarge.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeLarge),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              21,
                              Dimensions.paddingSizeSmall,
                              0,
                              Dimensions.paddingSizeSmall),
                          child: TextField(
                            controller: _shoppingAddress,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1),
                              ),
                              hintText: "Input Your Address",
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[300],
                        ),
                        Text(
                          'Order Detail',
                          style: poppinsBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: product.length,
                          itemBuilder: (ctx, index) {
                            final listProduct = product[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: Dimensions.paddingSizeSmall),
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
                                      imageErrorBuilder: (c, o, s) =>
                                          Image.asset(Images.placeholder,
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    width: Dimensions.marginSizeDefault),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${listProduct.product.model} ${listProduct.product.type}",
                                                style: poppinsRegular.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                    color: ColorResources
                                                        .primaryMaterial),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              width:
                                                  Dimensions.paddingSizeSmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                            height: Dimensions
                                                .marginSizeExtraSmall),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${listProduct.product.price!}'
                                                  .priceFormat(),
                                              style: poppinsSemiBold.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeLarge),
                                            ),
                                            Text('x ${listProduct.quantity}',
                                                style:
                                                    poppinsRegular.copyWith()),
                                          ],
                                        ),
                                      ]),
                                ),
                              ]),
                            );
                          },
                        ),
                        Container(
                          height: 35,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.055),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.event_note_outlined),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Payment Details',
                                  style: poppinsSemiBold.copyWith(
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: Dimensions.paddingSizeSmall),
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
                                Divider(
                                    height: 5,
                                    color: Theme.of(context).hintColor),
                                AmountWidget(
                                  title: 'Total :',
                                  amount: '$totalPrice'.priceFormat(),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
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
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey))),
                  height: 70,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: ColorResources.primaryMaterial,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                        child: Builder(
                      builder: (context) => Text(
                        'Make an Order',
                        style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                    )),
                  ),
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
