import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dukaandaar/features/sales/data/models/sales_model.dart';
import 'package:dukaandaar/features/sales/data/repositories/sales_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/theme.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../auth/data/models/user_model.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SaleRepositoryImpl saleRepositoryImpl;

  SalesBloc(this.saleRepositoryImpl) : super(SalesInitial()) {
    on<LoadSalesList>(_loadSales);
    on<NewSale>(_newSales);
    on<NewSalesInit>(_salesInit);
  }

  void _loadSales(LoadSalesList event, Emitter<SalesState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      final response = await saleRepositoryImpl.fetchOrder(user.orgId!, token);
      if (response == null || response.data == null) {
        emit(LoadSalesFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final List<SalesModel> inventories = salesModelFromJson(jsonEncode(data));

      if (response.statusCode == 401) {
        emit(LoadSalesFailure("Login failed."));
        return;
      }
      emit(LoadSalesSuccess(inventories));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadSalesFailure("An error occurred."));
    }
    return;
  }

  void _newSales(NewSale event, Emitter<SalesState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      final response = await saleRepositoryImpl.newOrder(
          user.orgId!, user.id, event.payload, token);
      if (response == null || response.data == null) {
        emit(NewSalesFailure("No response from server"));
        return;
      }
      print(response);
      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final SalesModel order = SalesModel.fromJson(data);

      if (response.statusCode == 401) {
        emit(NewSalesFailure("Login failed."));
        return;
      }
      emit(NewSalesSuccess(order));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(NewSalesFailure("An error occurred."));
    }
    return;
  }

  void _salesInit(NewSalesInit event, Emitter<SalesState> emit) async {}
}
