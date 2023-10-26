import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../data/models/product_response_model.dart';
import '../../../utils/dimensions.dart';
import 'product_item.dart';

class SearchBrand extends StatefulWidget {
  const SearchBrand({Key? key}) : super(key: key);

  @override
  State<SearchBrand> createState() => _SearchBrandState();
}

class _SearchBrandState extends State<SearchBrand> {
  TextEditingController _searchController = TextEditingController();
  List<Product> searchResults = [];
  bool noResults = false;

  void performSearchByBrand(List<Product> products) {
    final String brand = _searchController.text.toLowerCase();

    searchResults = products.where((product) {
      final productBrand = product.brand!.toLowerCase();
      return productBrand.contains(brand);
    }).toList();

    // if (searchResults.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Tidak ada produk dengan merek "$brand".'),
    //     ),
    //   );
    // }
    if (searchResults.isEmpty) {
      setState(() {
        noResults = true;
      });
    } else {
      noResults = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.white,
        elevation: 1,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorResources.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: poppinsRegular.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: ColorResources.black,
            ),
            border: InputBorder.none,
          ),
        ),
        actions: [
          // IconButton(
          //   padding: const EdgeInsets.only(right: 20),
          //   icon: const Icon(
          //     Icons.clear,
          //     size: 20,
          //     color: ColorResources.black,
          //   ),
          //   onPressed: () {
          //     _searchController.clear();
          //     setState(() {
          //       searchResults.clear();
          //     });
          //   },
          // ),
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 20,
              color: ColorResources.black,
            ),
            onPressed: () {
              BlocProvider.of<ProductBloc>(context).state.maybeWhen(
                    orElse: () {},
                    loaded: (model) {
                      performSearchByBrand(model.data ?? []);
                    },
                  );
            },
          ),
        ],
      ),
      body: noResults
          ? Center(
              child: Text('Tidak ada produk yang sesuai'),
            )
          : ListView(
              children: [
                MasonryGridView.count(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                  ),
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 8,
                  itemCount: searchResults.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductItem(product: searchResults[index]);
                  },
                ),
              ],
            ),
    );
  }
}
