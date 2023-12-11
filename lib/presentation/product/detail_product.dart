import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import '../../data/models/product_response_model.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import '../custom_widgets/rating_bar.dart';
import 'widgets/bottom_cart.dart';
import 'widgets/image_product.dart';
import 'widgets/title_product.dart';

class DetailProduct extends StatefulWidget {
  final Product product;
  const DetailProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();

        return true;
      },
      child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {},
            child: SafeArea(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ImageProduct(
                        image: widget.product.imageProduct!,
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -25.0, 0.0),
                        padding: const EdgeInsets.only(
                            top: Dimensions.fontSizeDefault),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                                Dimensions.paddingSizeExtraLarge),
                            topRight: Radius.circular(
                                Dimensions.paddingSizeExtraLarge),
                          ),
                          border: Border.all(
                            color: ColorResources.grey,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleProduct(
                              product: widget.product,
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       vertical: 5, horizontal: 10),
                                  //   child: Text(
                                  //     '${widget.product.price!}'.priceFormat(),
                                  //     style: poppinsBold.copyWith(
                                  //         color: ColorResources.primaryMaterial,
                                  //         fontSize: Dimensions.fontSizeLarge),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RatingBar(
                                        rating: double.parse(
                                            '${widget.product.rating}'),
                                        size: Dimensions.fontSizeLarge,
                                      ),
                                      SizedBox(width: 1),
                                      Text('${widget.product.rating}',
                                          style: poppinsRegular.copyWith(
                                            fontSize: Dimensions.fontSizeLarge,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    // indent: Dimensions.paddingSizeDefault,
                                    // endIndent: Dimensions.paddingSizeDefault,
                                    thickness: 2,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Detail Specification",
                                      style: poppinsBold.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Table(
                                    border: TableBorder.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                    children: [
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Range'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.range} km'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Power Motor'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.powerMotor} W'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Battery'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.battery}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Wheel Size'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.wheelSize} inch'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Wheel Type'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.wheelType}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Max Load'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.maxLoad} kg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Top Speed'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.topSpeed} km/h'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Waterproof'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.waterproof ?? ''} '),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Weight'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.weight} kg'),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              color: Colors.grey[200],
                                              child: Text('Bracket Type'),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  '${widget.product.bracketType}'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   height: MediaQuery.of(context).size.height,
                            //   margin: const EdgeInsets.only(
                            //       top: Dimensions.paddingSizeSmall),
                            //   padding: const EdgeInsets.all(
                            //       Dimensions.paddingSizeSmall),
                            //   child: SpesificationProduct(
                            //     spesificationProduct: widget.product.wheelType!,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          bottomNavigationBar: BottomCart(
            product: widget.product,
          )),
    );
  }
}
