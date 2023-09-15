import 'package:flutter/material.dart';
import '../../data/models/product_response_model.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import 'widgets/bottom_cart.dart';
import 'widgets/image_product.dart';
import 'widgets/spesification_product.dart';
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
          appBar: AppBar(
            title: Row(children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.arrow_back_ios,
                      color: Theme.of(context).cardColor, size: 20),
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Text('Product Detail',
                  style: poppinsRegular.copyWith(
                      fontSize: 20, color: Theme.of(context).cardColor)),
            ]),
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: RefreshIndicator(
            onRefresh: () async {},
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
                                Dimensions.paddingSizeExtraLarge)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleProduct(
                            product: widget.product,
                          ),
                          Container(
                            height: 250,
                            margin: const EdgeInsets.only(
                                top: Dimensions.paddingSizeSmall),
                            padding: const EdgeInsets.all(
                                Dimensions.paddingSizeSmall),
                            child: SpesificationProduct(
                                spesificationProduct:
                                    widget.product.wheelType!),
                          ),
                          const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          bottomNavigationBar: BottomCart(
            product: widget.product,
          )),
    );
  }
}
