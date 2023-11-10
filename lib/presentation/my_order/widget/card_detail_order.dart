// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_garasi_ev/utils/price_format.dart';

import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';

class CardDetailOrder extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String price;
  final String quantity;
  final String total;
  final bool showDivider;
  const CardDetailOrder({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.total,
    required this.showDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
    //   // decoration: BoxDecoration(
    //   //   color: Colors.white,
    //   //   borderRadius: BorderRadius.circular(16),
    //   //   border: Border.all(color: const Color(0xffD8D8D8), width: 1),
    //   // ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           ClipRRect(
    //             borderRadius: const BorderRadius.only(
    //               topLeft: Radius.circular(16),
    //               bottomLeft: Radius.circular(16),
    //             ),
    //             child: Image.network(
    //               imageUrl,
    //               height: 90,
    //               width: 80,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           const SizedBox(
    //             width: 10,
    //           ),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(name,
    //                   style: poppinsRegular.copyWith(
    //                       fontSize: Dimensions.fontSizeDefault,
    //                       fontWeight: FontWeight.w700),
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis),
    //               const SizedBox(
    //                 height: 4,
    //               ),
    //               Text(
    //                 price,
    //                 style: poppinsRegular.copyWith(
    //                   color: ColorResources.red,
    //                   fontSize: 15,
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 4,
    //               ),
    //               const SizedBox(
    //                 height: 4,
    //               ),
    //             ],
    //           ),
    //           Text(
    //             quantity,
    //             style: poppinsRegular.copyWith(),
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               Text(
    //                 "${quantity} x ${price}",
    //                 style: poppinsRegular.copyWith(),
    //               ),
    //               Text(total),
    //             ],
    //           ),
    //         ],
    //       ),
    //       Divider(
    //         thickness: 2,
    //         color: Colors.grey,
    //       ),
    //     ],
    //   ),
    // );

    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: poppinsRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      price,
                      style: poppinsRegular.copyWith(
                          color: ColorResources.red,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity",
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        Text(
                          quantity,
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          if (showDivider)
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
        ],
      ),
    );
  }
}
