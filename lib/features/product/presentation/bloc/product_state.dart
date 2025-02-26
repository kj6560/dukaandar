part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class LoadProductSuccess extends ProductState {
  final List<Product> response;
  LoadProductSuccess(this.response);
}

class LoadProductListFailure extends ProductState {
  final String error;
  LoadProductListFailure(this.error);
}

class AddProductSuccess extends ProductState {
  final Product response;
  AddProductSuccess(this.response);
}

class AddProductFailure extends ProductState {
  final String error;
  AddProductFailure(this.error);
}
