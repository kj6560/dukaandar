part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProductList extends ProductEvent {
  const LoadProductList();
}

class AddNewProduct extends ProductEvent {
  final String name;
  final double price;
  final String sku;

  const AddNewProduct(
      {required this.name, required this.price, required this.sku});
}
