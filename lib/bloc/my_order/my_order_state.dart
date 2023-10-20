part of 'my_order_bloc.dart';

@freezed
class MyOrderState with _$MyOrderState {
  const factory MyOrderState.initial() = _Initial;
  const factory MyOrderState.loading() = _Loading;
  const factory MyOrderState.loaded(MyOrderResponseModel model) = _Loaded;
  const factory MyOrderState.error(String message) = _Error;
}
