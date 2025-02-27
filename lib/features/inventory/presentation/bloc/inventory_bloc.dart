import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/config/theme.dart';
import '../../../../core/local/hive_constants.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/inventory_model.dart';
import '../../data/repositories/inventory_repository.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryRepositoryImpl inventoryRepositoryImpl;

  InventoryBloc(this.inventoryRepositoryImpl) : super(InventoryInitial()) {
    on<LoadInventoryList>(_loadInventory);
    on<AddInventory>(_addInventory);
  }

  void _loadInventory(
      LoadInventoryList event, Emitter<InventoryState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      final response =
          await inventoryRepositoryImpl.fetchInventory(user.orgId!, token);
      if (response == null || response.data == null) {
        emit(LoadInventoryFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final List<InventoryModel> inventories =
          inventoryModelFromJson(jsonEncode(data));

      if (response.statusCode == 401) {
        emit(LoadInventoryFailure("Login failed."));
        return;
      }
      emit(LoadInventorySuccess(inventories));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(LoadInventoryFailure("An error occurred."));
    }
    return;
  }

  void _addInventory(AddInventory event, Emitter<InventoryState> emit) async {
    try {
      String userString = await authBox.get(HiveKeys.userBox);
      String token = await authBox.get(HiveKeys.accessToken);
      User user = User.fromJson(jsonDecode(userString));
      print('user org id: ${user.orgId}');
      String sku = event.sku;
      double quantity = event.quantity;
      final response = await inventoryRepositoryImpl.addInventory(
          user.orgId!, sku, quantity, token);
      if (response == null || response.data == null) {
        emit(AddInventoryFailure("No response from server"));
        return;
      }

      // Ensure data is always a Map<String, dynamic>
      final data = response.data['data'] is String
          ? jsonDecode(response.data['data'])
          : response.data['data'];
      print(data);
      final InventoryModel inventory = InventoryModel.fromJson(data);

      if (response.statusCode == 401) {
        emit(AddInventoryFailure("Login failed."));
        return;
      }
      emit(AddInventorySuccess(inventory));
    } catch (e, stacktrace) {
      print('Exception in bloc: $e');
      print('Stacktrace: $stacktrace');
      emit(AddInventoryFailure("An error occurred."));
    }
    return;
  }
}
