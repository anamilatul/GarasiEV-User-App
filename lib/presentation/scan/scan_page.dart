// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_garasi_ev/presentation/product/widgets/add_product_snackbar.dart';
// import 'package:flutter_garasi_ev/presentation/scan/result_scan.dart';
// import 'package:flutter_garasi_ev/utils/color_resources.dart';

// import '../../bloc/product/product_bloc.dart';
// import '../../data/models/product_response_model.dart';
// import '../../utils/costum_themes.dart';
// import '../../utils/dimensions.dart';

// class ScanPage extends StatefulWidget {
//   const ScanPage({super.key});

//   @override
//   State<ScanPage> createState() => _ScanPageState();
// }

// class _ScanPageState extends State<ScanPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductBloc>().add(
//           const ProductEvent.getAll(),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: ColorResources.primaryMaterial,
//         elevation: 1,
//         leading: IconButton(
//           padding: const EdgeInsets.only(left: 20),
//           icon: const Icon(
//             Icons.arrow_back,
//             color: ColorResources.homeBg,
//             size: 20,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Scan Product',
//         ),
//       ),
//       body: Center(
//         child: Container(
//           color: ColorResources.homeBg,
//           padding: const EdgeInsets.all(40),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Color.fromARGB(255, 235, 234, 234),
//                 ),
//                 child: Text(
//                   'Please scan the product via the QR Code then click the button below',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               const Icon(
//                 Icons.qr_code_scanner,
//                 size: 250,
//               ),
//               const SizedBox(
//                 height: 90,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     backgroundColor: ColorResources.primaryMaterial,
//                   ),
//                   onPressed: scanBarcode,
//                   child: Text(
//                     "Scan",
//                     style: poppinsRegular.copyWith(
//                       fontSize: Dimensions.fontSizeExtraLarge,
//                       color: Theme.of(context).cardColor,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> scanBarcode() async {
//     String idProduct = await FlutterBarcodeScanner.scanBarcode(
//       "#ff6666",
//       "Cancel",
//       true,
//       ScanMode.QR,
//     );

//     final productBloc = context.read<ProductBloc>();

//     productBloc.add(ProductEvent.getAll());

//     Product? scannedProduct = productBloc.findProductById(idProduct);

//     if (scannedProduct != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ResultScanPage(scannedProduct),
//         ),
//       );
//     } else {
//       CustomSnackbar.showSnackbar(
//         context,
//         "Product not found",
//         actionText: '',
//         onPressed: () {},
//       );
//     }
//   }
// }
