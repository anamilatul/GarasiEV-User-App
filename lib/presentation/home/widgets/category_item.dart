// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/product/category_product_page.dart';
import '../../../data/models/category_response_model.dart';
import '../../../utils/color_resources.dart';
import '../../../utils/costum_themes.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProductsPage(
                      id: category.id!,
                      name: category.name!,
                    )));
      },
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.width / 5,
          width: MediaQuery.of(context).size.width / 5,
          decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.2)),
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            color: Theme.of(context).highlightColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: Images.placeholder,
              image: 'https://picsum.photos/20${category.id}',
              imageErrorBuilder: (c, o, s) => Image.asset(
                Images.placeholder,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Center(
          child: Text(
            category.name ?? '-',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: poppinsRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ),
      ]),
    );
  }
}
