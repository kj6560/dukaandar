part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();

  @override
  List<Object> get props => [];
}

class LoadInventoryList extends InventoryEvent {
  const LoadInventoryList();
}

class AddInventory extends InventoryEvent {
  const AddInventory();
}
