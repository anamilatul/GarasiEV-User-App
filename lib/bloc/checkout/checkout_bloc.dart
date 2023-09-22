import 'package:bloc/bloc.dart';
import 'package:flutter_garasi_ev/data/models/product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';
part 'checkout_bloc.freezed.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const _Loaded([])) {
    on<_AddToCart>((event, emit) {
      final currentState = state as _Loaded;
      final productQuantity = ProductQuantity(
        product: event.product,
        quantity: event.quantity,
      );
      if (currentState.product
          .where((element) => element.product == event.product)
          .isNotEmpty) {
        for (var productQuantity in currentState.product) {
          if (productQuantity.product == event.product) {
            productQuantity.quantity =
                productQuantity.quantity + event.quantity;
          }
        }
        final newState = currentState.product;
        emit(const _Loading());
        emit(_Loaded(newState));
      } else {
        emit(_Loaded([
          ...currentState.product,
          productQuantity,
        ]));
      }
    });
    on<_RemoveProductInCart>((event, emit) {
      final currentState = state as _Loaded;
      if (currentState.product
          .where((element) => element.product == event.product)
          .isNotEmpty) {
        var products = [...currentState.product];
        products.removeWhere((element) => element.product == event.product);
        final newState = products;
        emit(const _Loading());
        emit(_Loaded(newState));
      } else {
        emit(_Loaded([
          ...currentState.product,
        ]));
      }
    });
    on<_Clear>((event, emit) {
      emit(const _Loaded([]));
    });
  }
}
