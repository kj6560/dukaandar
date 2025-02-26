import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dukaandaar/features/product/data/models/products_model.dart';
import 'package:dukaandaar/features/product/data/repositories/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/theme.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../auth/data/models/user_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryImpl productRepositoryImpl;

  ProductBloc(this.productRepositoryImpl) : super(ProductInitial()) {
    on<LoadProductList>(_loadProduct);
    on<AddNewProduct>(_addNewProduct);
  }

  void _loadProduct(LoadProductList event, Emitter<ProductState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      final response =
          await productRepositoryImpl.fetchProducts(user.orgId!, token);
      if (response == null || response.data == null) {
        emit(LoadProductListFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final List<Product> products = productFromJson(jsonEncode(data));

      if (response.statusCode == 401) {
        emit(LoadProductListFailure("Login failed."));
        return;
      }
      emit(LoadProductSuccess(products));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadProductListFailure("An error occurred."));
    }
    return;
  }

  void _addNewProduct(AddNewProduct event, Emitter<ProductState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      int org_id = user.orgId;
      String name = event.name;
      String sku = event.sku;
      double product_mrp = event.price;
      final response = await productRepositoryImpl.addProducts(
          org_id, token, name, sku, product_mrp);
      if (response == null || response.data == null) {
        emit(AddProductFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final Product product = Product.fromJson(data);

      if (response.statusCode == 401) {
        emit(AddProductFailure("Login failed."));
        return;
      }
      emit(AddProductSuccess(product));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(AddProductFailure("An error occurred."));
    }
    return;
  }
}
