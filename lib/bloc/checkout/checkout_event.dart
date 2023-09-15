part of 'checkout_bloc.dart';

@freezed
class CheckoutEvent with _$CheckoutEvent {
  const factory CheckoutEvent.started() = _Started;
  const factory CheckoutEvent.addToCart(Product product, int quantity) =
      _AddToCart;
  const factory CheckoutEvent.removeProductInCart(
      Product product, int quantity) = _RemoveProductInCart;
}
