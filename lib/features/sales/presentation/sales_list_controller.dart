library sales_list_library;

import 'package:flutter/material.dart';

import '../../../core/routes.dart';
import '../../../core/widget_view_base.dart';

part 'sales_list_screen.dart';

class SalesListController extends StatefulWidget {
  const SalesListController({super.key});

  @override
  State<SalesListController> createState() => SalesListControllerState();
}

class SalesListControllerState extends State<SalesListController> {
  @override
  Widget build(BuildContext context) => SalesListUi(this);
}
