part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.getAll() = _GetAll;
  const factory ProductEvent.getProductByCategory(int categoryId) =
      _GetProductByCategory;
}
