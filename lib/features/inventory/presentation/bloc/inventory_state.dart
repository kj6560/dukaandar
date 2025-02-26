part of 'inventory_bloc.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

class LoadInventorySuccess extends InventoryState {
  final List<InventoryModel> response;

  LoadInventorySuccess(this.response);
}

class LoadInventoryFailure extends InventoryState {
  final String error;

  LoadInventoryFailure(this.error);
}
