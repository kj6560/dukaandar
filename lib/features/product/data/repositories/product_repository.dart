import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';

class ProductRepositoryImpl {
  final Dio dio;

  ProductRepositoryImpl({required this.dio});

  Future<Response?> fetchProducts(int org_id, String token) async {
    try {
      var body = {'org_id': org_id};

      Response response = await dio.get(
        EndPoints.fetchProducts,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(body),
      );
      return response;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace);
    }
  }

  Future<Response?> addProducts(int org_id, String token, String name,
      String sku, double product_mrp) async {
    try {
      var body = {
        'org_id': org_id,
        'name': name,
        'sku': sku,
        'product_mrp': product_mrp,
      };
      print(body);
      Response response = await dio.post(
        EndPoints.addProduct,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: jsonEncode(body),
      );
      return response;
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace);
    }
  }
}
