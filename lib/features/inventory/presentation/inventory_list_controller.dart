library inventory_library;

import 'package:flutter/material.dart';

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
  }

  @override
  Widget build(BuildContext context) => InventoryListUi(this);
}
