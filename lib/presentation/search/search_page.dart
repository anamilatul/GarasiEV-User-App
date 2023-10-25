import 'package:flutter/material.dart';
import 'package:flutter_garasi_ev/presentation/custom_widgets/button/custom_button.dart';
import 'package:flutter_garasi_ev/utils/color_resources.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../bloc/product/product_bloc.dart';
import '../../data/models/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/costum_themes.dart';
import '../../utils/dimensions.dart';
import '../custom_widgets/text_field/custom_textfield.dart';
import '../home/widgets/product_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController speedController = TextEditingController();

  final FocusNode _weightNode = FocusNode();
  final FocusNode _rangeNode = FocusNode();
  final FocusNode _speedeNode = FocusNode();

  List<Product> searchResults = [];
  void performSearch(List<Product> products) {
    final double weight = double.tryParse(weightController.text) ?? 0.0;
    final int range = int.tryParse(rangeController.text) ?? 0;
    final double speed = double.tryParse(speedController.text) ?? 0.0;
    searchResults.clear();
    for (Product product in products) {
      if (product.maxLoad! >= weight &&
          product.range! >= range &&
          product.topSpeed! >= speed) {
        searchResults.add(product);
      }
    }

    if (searchResults.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak ada produk yang sesuai dengan kriteria.'),
        ),
      );
    }
    weightController.clear();
    rangeController.clear();
    speedController.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search ',
          style: poppinsRegular.copyWith(fontSize: 20, color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (model) {
              final products = model.data ?? [];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // Text(
                        //   "Here you can search for Garasi EV products, \naccording to what you need !",
                        //   style: poppinsRegular.copyWith(fontSize: 15, color: Colors.black),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        CustomTextField(
                          hintText: 'Berat Badan Driver (kg)',
                          focusNode: _weightNode,
                          nextNode: _rangeNode,
                          textInputType: TextInputType.number,
                          controller: weightController,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hintText: 'Jarak',
                          focusNode: _rangeNode,
                          nextNode: _speedeNode,
                          textInputType: TextInputType.number,
                          controller: rangeController,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextField(
                          hintText: 'Kecepatan',
                          focusNode: _speedeNode,
                          textInputType: TextInputType.number,
                          controller: speedController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                            onTap: () {
                              performSearch(products);
                            },
                            buttonText: "Find"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        MasonryGridView.count(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
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
                  ),
                ],
              );
            },
            error: (message) {
              return Center(
                child: Text("Server Error: $message"),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorResources.primaryMaterial,
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const ScanScreen()));
        },
        child: const Icon(
          Icons.qr_code_scanner,
          color: ColorResources.white,
        ),
      ),
    );
  }
}
