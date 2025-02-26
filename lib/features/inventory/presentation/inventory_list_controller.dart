library inventory_library;

import 'package:dukaandaar/features/inventory/data/models/inventory_model.dart';
import 'package:dukaandaar/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes.dart';
import '../../../core/widget_view_base.dart';

part 'inventory_list_screen.dart';

class InventoryListController extends StatefulWidget {
  const InventoryListController({super.key});

  @override
  State<InventoryListController> createState() =>
      InventoryListControllerState();
}

class InventoryListControllerState extends State<InventoryListController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<InventoryBloc>(context).add(LoadInventoryList());
  }

  @override
  Widget build(BuildContext context) => InventoryListUi(this);
}
