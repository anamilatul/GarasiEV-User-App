import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';
import '../models/banner_response_model.dart';

class BannerRemoteDataSource {
  Future<Either<String, BannerResponseModel>> getBanner() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/banner'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(BannerResponseModel.fromJson(response.body));
    } else {
      return const Left("Server Error");
    }
  }
}
