import 'package:bloc/bloc.dart';
import 'package:flutter_garasi_ev/data/datasources/order_remote_datasource.dart';
import 'package:flutter_garasi_ev/data/models/my_order_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_order_event.dart';
part 'my_order_state.dart';
part 'my_order_bloc.freezed.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  MyOrderBloc() : super(_Initial()) {
    on<_GetMyOrder>((event, emit) async {
      emit(const _Loading());
      final result = await OrderRemoteDataSource().getMyOrder();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
