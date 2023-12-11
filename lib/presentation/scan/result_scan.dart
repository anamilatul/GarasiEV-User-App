import 'package:flutter/material.dart';
import '../../data/models/product_response_model.dart';

class ResultScanPage extends StatelessWidget {
  final Product scannedProduct;

  const ResultScanPage(this.scannedProduct);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product Details:'),
            Text('ID: ${scannedProduct.id}'),
            Text('Type: ${scannedProduct.brand}'),
            // Tambahkan atribut lain sesuai kebutuhan
          ],
        ),
      ),
    );
  }
}
