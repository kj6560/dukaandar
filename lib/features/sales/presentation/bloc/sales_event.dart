part of 'sales_bloc.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}

class LoadSalesList extends SalesEvent {
  const LoadSalesList();
}
