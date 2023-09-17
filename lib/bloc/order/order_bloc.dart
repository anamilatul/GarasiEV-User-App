import 'package:bloc/bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/order_remote_datasource.dart';
import 'package:flutter_garasi_ev/data/models/order_response_model.dart';
import 'package:flutter_garasi_ev/data/models/request/order_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const _Initial()) {
    on<_Order>((event, emit) async {
      emit(const _Loading());
      final result = await OrderRemoteDataSource().order(event.model);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
