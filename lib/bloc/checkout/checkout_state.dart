// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

@freezed
class CheckoutState with _$CheckoutState {
  // const factory CheckoutState.initial() = _Initial;
  const factory CheckoutState.loading() = _Loading;
  const factory CheckoutState.loaded(List<ProductQuantity> product) = _Loaded;
}

class ProductQuantity {
  final Product product;
  int quantity;
  ProductQuantity({
    required this.product,
    required this.quantity,
  });

  @override
  bool operator ==(covariant ProductQuantity other) {
    if (identical(this, other)) return true;

    return other.product == product && other.quantity == quantity;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode;
}
