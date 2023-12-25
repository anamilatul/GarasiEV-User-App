import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_garasi_ev/presentation/home/widgets/card_item.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import 'package:flutter_garasi_ev/utils/costum_themes.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../bloc/product/product_bloc.dart';
import '../../data/models/product_response_model.dart';
import '../../utils/dimensions.dart';

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
      final productModel = product.model!.toLowerCase();

      return productBrand.contains(brand) || productModel.contains(brand);
    }).toList();

    if (searchResults.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nothing product "$brand".'),
        ),
      );
    }
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          IconButton(
            padding: const EdgeInsets.only(right: 20),
            icon: const Icon(
              Icons.clear,
              size: 20,
              color: ColorResources.red,
            ),
            onPressed: () {
              _searchController.clear();
              setState(() {
                searchResults.clear();
              });
            },
          ),
          Container(
            decoration: BoxDecoration(color: ColorResources.primaryMaterial),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 20,
                color: ColorResources.white,
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
          ),
        ],
      ),
      body: searchResults.isEmpty
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_backpack_outlined,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Nothing product to show',
                    style: poppinsRegular.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView(
              children: [
                MasonryGridView.count(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  physics: const BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 8,
                  itemCount: searchResults.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return CardItem(product: searchResults[index]);
                  },
                ),
              ],
            ),
    );
  }
}
