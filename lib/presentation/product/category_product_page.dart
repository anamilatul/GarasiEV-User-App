import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../bloc/product/product_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import '../home/widgets/product_item.dart';

class CategoryProductsPage extends StatefulWidget {
  final int id;
  final String? name;
  const CategoryProductsPage({
    Key? key,
    required this.id,
    this.name,
  }) : super(key: key);

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
          ProductEvent.getProductByCategory(
            widget.id,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.iconBg,
      appBar: AppBar(
        title: Row(children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text('${widget.name}',
              style:
                  poppinsRegular.copyWith(fontSize: 20, color: Colors.black)),
        ]),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimensions.paddingSizeSmall),
          // Products
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Expanded(
                    child: const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                },
                loaded: (model) {
                  return Expanded(
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 8,
                      itemCount: model.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(product: model.data![index]);
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
