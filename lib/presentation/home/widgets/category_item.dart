// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/product/category_product_page.dart';
import '../../../data/models/category_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/dimensions.dart';

class CategoryItem extends StatefulWidget {
  final Category category;
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return CategoryProductsPage(
                id: widget.category.id!,
                name: widget.category.name!,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              var scaleAnimation = animation.drive(tween);

              return ScaleTransition(
                scale: scaleAnimation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.homePagePadding,
          vertical: Dimensions.paddingSizeExtraSmall,
        ),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              isClicked ? ColorResources.white : ColorResources.white, //primary
          border: Border.all(
            color: isClicked
                ? ColorResources.black
                : ColorResources.black, //primary
          ),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
        ),
        child: Text(
          widget.category.name ?? '-',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color:
                isClicked ? ColorResources.black : ColorResources.black, //white
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
      ),
    );
  }
}
