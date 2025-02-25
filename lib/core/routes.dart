import 'package:dukaandaar/features/home/presentation/home_controller.dart';
import 'package:dukaandaar/features/inventory/presentation/inventory_list_controller.dart';
import 'package:dukaandaar/features/product/presentation/new_product_controller.dart';
import 'package:dukaandaar/features/product/presentation/product_list_controller.dart';
import 'package:dukaandaar/features/sales/presentation/new_sale_controller.dart';
import 'package:dukaandaar/features/sales/presentation/sales_list_controller.dart';
import 'package:flutter/material.dart';

import '../features/auth/presentation/forgot_pass/forgot_pass_screen.dart';
import '../features/auth/presentation/login/login_controller.dart';
import '../features/auth/presentation/register/register_screen.dart';
import '../features/inventory/presentation/new_inventory_controller.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String listInventory = '/list_inventory';
  static const String listProduct = '/list_product';
  static const String listSales = '/list_sales';
  static const String newProduct = '/new_product';
  static const String newSale = '/new_sale';
  static const String newInventory = '/new_Inventory';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreenController());
      case listInventory:
        return MaterialPageRoute(builder: (_) => InventoryListController());
      case listProduct:
        return MaterialPageRoute(builder: (_) => ProductListController());
      case listSales:
        return MaterialPageRoute(builder: (_) => SalesListController());
      case newProduct:
        return MaterialPageRoute(builder: (_) => NewProductController());

      case newSale:
        return MaterialPageRoute(builder: (_) => NewSaleController());
      case newInventory:
        return MaterialPageRoute(builder: (_) => NewInventoryController());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
