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
}
