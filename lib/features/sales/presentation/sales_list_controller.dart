library sales_list_library;

import 'package:dukaandaar/features/sales/presentation/bloc/sales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes.dart';
import '../../../core/widget_view_base.dart';
import '../data/models/sales_model.dart';

part 'sales_list_screen.dart';

class SalesListController extends StatefulWidget {
  const SalesListController({super.key});

  @override
  State<SalesListController> createState() => SalesListControllerState();
}

class SalesListControllerState extends State<SalesListController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SalesBloc>(context).add(LoadSalesList());
  }

  @override
  Widget build(BuildContext context) => SalesListUi(this);
}
