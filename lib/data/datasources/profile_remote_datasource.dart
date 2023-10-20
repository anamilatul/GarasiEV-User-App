import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../../common/global_variables.dart';
import '../models/profile_response_model.dart';
import 'auth_local_datasource.dart';

class ProfileRemoteDataSource {
  Future<Either<String, ProfileResponseModel>> getProfile() async {
    final token = await AuthLocalDataSource().getToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/user'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(ProfileResponseModel.fromJson(response.body));
    } else {
      return const Left("Server Error");
    }
  }
}
