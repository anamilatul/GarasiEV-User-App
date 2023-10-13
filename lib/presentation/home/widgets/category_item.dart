// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/product/category_product_page.dart';
import '../../../data/models/category_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
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
          MaterialPageRoute(
            builder: (context) => CategoryProductsPage(
              id: widget.category.id!,
              name: widget.category.name!,
            ),
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
              isClicked ? ColorResources.primaryMaterial : ColorResources.white,
          border: Border.all(
            color: isClicked
                ? ColorResources.primaryMaterial
                : ColorResources.black,
          ),
          borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraLarge),
        ),
        child: Text(
          widget.category.name ?? '-',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isClicked ? ColorResources.white : ColorResources.black,
            fontSize: Dimensions.fontSizeSmall,
          ),
        ),
      ),
    );
  }
}
