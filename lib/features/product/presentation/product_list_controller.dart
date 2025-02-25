library product_list_library;

import 'package:flutter/material.dart';

import '../../../core/widget_view_base.dart';

part 'product_list_screen.dart';

class ProductListController extends StatefulWidget {
  const ProductListController({super.key});

  @override
  State<ProductListController> createState() => ProductListControllerState();
}

class ProductListControllerState extends State<ProductListController> {
  @override
  Widget build(BuildContext context) => ProductListUi(this);
}
