import 'package:bloc/bloc.dart';
import 'package:dukaandaar/features/sales/data/repositories/sales_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SaleRepositoryImpl saleRepositoryImpl;

  SalesBloc(this.saleRepositoryImpl) : super(SalesInitial()) {
    on<LoadSalesList>(_loadSales);
  }
  void _loadSales(LoadSalesList event, Emitter<SalesState> emit) async {}
}
