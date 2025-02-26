import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/network/endpoints.dart';

class InventoryRepositoryImpl {
  final Dio dio;

  InventoryRepositoryImpl({required this.dio});

  Future<Response?> fetchInventory(int org_id, String token) async {
    try {
      var body = {'org_id': org_id};

      Response response = await dio.get(
        EndPoints.fetchInventory,
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
