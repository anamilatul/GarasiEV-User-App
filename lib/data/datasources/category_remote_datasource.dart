import 'package:dartz/dartz.dart';
import 'package:flutter_garasi_ev/data/models/category_response_model.dart';
import 'package:http/http.dart' as http;

import '../../common/global_variables.dart';

class CategoryRemoteDataSource {
  Future<Either<String, CategoryResponseModel>> getCategory() async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/categories'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(CategoryResponseModel.fromJson(response.body));
    } else {
      return const Left("Server Error");
    }
  }
}
