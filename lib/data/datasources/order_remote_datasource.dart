import 'package:dartz/dartz.dart';
import 'package:flutter_garasi_ev/data/datasources/auth_local_datasource.dart';
import 'package:flutter_garasi_ev/data/models/order_response_model.dart';
import 'package:flutter_garasi_ev/data/models/request/order_request_model.dart';
import 'package:http/http.dart' as http;
import '../../common/global_variables.dart';
import '../models/my_order_response_model.dart';

class OrderRemoteDataSource {
  Future<Either<String, OrderResponseModel>> order(
      OrderRequestModel orderRequestModel) async {
    final token = await AuthLocalDataSource().getToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/order'),
      headers: headers,
      body: orderRequestModel.toJson(),
    );
    if (response.statusCode == 200) {
      return Right(OrderResponseModel.fromJson(response.body));
    } else {
      return const Left("Server Error");
    }
  }

  Future<Either<String, MyOrderResponseModel>> getMyOrder() async {
    final token = await AuthLocalDataSource().getToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${GlobalVariables.baseUrl}/api/orders'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return Right(MyOrderResponseModel.fromJson(response.body));
    } else {
      return const Left("Server Error");
    }
  }
}
