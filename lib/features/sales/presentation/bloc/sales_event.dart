part of 'sales_bloc.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();

  @override
  List<Object> get props => [];
}

class LoadSalesList extends SalesEvent {
  const LoadSalesList();
}

class NewSalesInit extends SalesEvent {
  NewSalesInit();
}

class NewSale extends SalesEvent {
  final String payload;
  const NewSale({required this.payload});
}
