import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../bloc/product/product_bloc.dart';
import '../../utils/color_resources.dart';
import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import '../home/widgets/product_item.dart';

class AllProductPage extends StatefulWidget {
  const AllProductPage({Key? key}) : super(key: key);

  @override
  State<AllProductPage> createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
          const ProductEvent.getAll(), // Ganti ini dengan event yang sesuai
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
              child: Icon(Icons.arrow_back, color: Colors.black, size: 20),
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Text('All Products', // Ganti ini dengan judul yang sesuai
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
                    child: StaggeredGridView.countBuilder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 8,
                      itemCount: model.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(product: model.data![index]);
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
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
