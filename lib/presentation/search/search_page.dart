import 'package:flutter/material.dart';

import '../../bloc/product/product_bloc.dart';
import '../../data/models/product_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController speedController = TextEditingController();

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
        title: const Text('Pencarian Produk'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(
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
                        TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Berat Badan Driver (kg)',
                          ),
                        ),
                        TextField(
                          controller: rangeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Jarak',
                          ),
                        ),
                        TextField(
                          controller: speedController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Kecepatan',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            performSearch(products);
                          },
                          child: const Text('Cari'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final product = searchResults[index];
                        return ListTile(
                          title: Text(
                            "${product.model ?? '-'} ${product.type ?? '-'}",
                          ),
                        );
                      },
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
    );
  }
}
