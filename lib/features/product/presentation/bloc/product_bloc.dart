import 'package:bloc/bloc.dart';
import 'package:dukaandaar/features/product/data/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryImpl productRepositoryImpl;

  ProductBloc(this.productRepositoryImpl) : super(ProductInitial()) {
    on<LoadProductList>(_loadProduct);
  }
  void _loadProduct(LoadProductList event, Emitter<ProductState> emit) async {}
}
