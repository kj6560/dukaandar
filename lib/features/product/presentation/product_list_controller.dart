library product_list_library;

import 'package:dukaandaar/core/routes.dart';
import 'package:dukaandaar/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widget_view_base.dart';
import '../data/models/products_model.dart';

part 'product_list_screen.dart';

class ProductListController extends StatefulWidget {
  const ProductListController({super.key});

  @override
  State<ProductListController> createState() => ProductListControllerState();
}

class ProductListControllerState extends State<ProductListController> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(LoadProductList());
  }

  @override
  Widget build(BuildContext context) => ProductListUi(this);
}
