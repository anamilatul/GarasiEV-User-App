import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/my_order/widget/card_detail_order.dart';
import 'package:flutter_garasi_ev/utils/price_format.dart';

import '../../data/models/my_order_response_model.dart';
import '../../utils/color_resources.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';

class DetailOrderPage extends StatelessWidget {
  final Order order;
  const DetailOrderPage({required this.order});

  @override
  Widget build(BuildContext context) {
    int totalOrderPrice = order.orderItems.fold<int>(0, (total, item) {
      // Harga produk dikalikan dengan kuantitas
      return total + (item.product.price * item.quantity);
    });

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
              'Detail Order',
              style: poppinsRegular.copyWith(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: ListView(
          children: [
            for (var item in order.orderItems)
              CardDetailOrder(
                name: "${item.product.brand} ${item.product.model}",
                imageUrl: "${item.product.imageUrl}",
                price: "${item.product.price}".priceFormat(),
                quantity: "${item.quantity}",
                total: "${item.product.price * item.quantity}".priceFormat(),
                showDivider: true,
              ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Order",
                    style: poppinsBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: ColorResources.red),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Shipping Address',
                    style: poppinsBold.copyWith(
                        fontSize: Dimensions.fontSizeDefault),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "${order.deliveryAddress}",
                      maxLines: 1,
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Number",
                        style: poppinsBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                      Text(
                        " ${order.number}",
                        style: poppinsBold.copyWith(
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                    ],
                  ),
                  for (var item in order.orderItems)
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "• ${item.product.brand} ${item.product.model} x ${item.quantity}",
                            style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          Text(
                            "${item.product.price * item.quantity}"
                                .priceFormat(),
                            style: poppinsRegular.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                        ],
                      ),
                    ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: poppinsBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge),
                      ),
                      Text(
                        '${order.totalPrice}'.priceFormat(),
                        style: poppinsBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
