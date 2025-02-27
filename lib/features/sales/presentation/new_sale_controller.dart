library new_sale_library;

import 'package:dukaandaar/features/sales/data/models/new_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widget_view_base.dart';
import 'bloc/sales_bloc.dart';

part 'new_sale_screen.dart';

class NewSaleController extends StatefulWidget {
  const NewSaleController({super.key});

  @override
  State<NewSaleController> createState() => NewSaleControllerState();
}

class NewSaleControllerState extends State<NewSaleController> {
  Future<String> scanBarcode() async {
    String _scanBarcode = "";
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      //Handle the scanned barcode result
      setState(() {
        _scanBarcode = barcodeScanRes;
      });
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!_scanBarcode.isNotEmpty) {
      return _scanBarcode;
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return _scanBarcode;
    return _scanBarcode;
  }

  final formKey = GlobalKey<FormState>();
  List<NewOrder> orders = [];
  TextEditingController quantityController = TextEditingController();
  TextEditingController skuController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController taxController = TextEditingController();

  void updateOrder(NewOrder newOrder) {
    setState(() {
      // Check if the SKU already exists in the list
      int existingIndex =
          orders.indexWhere((order) => order.sku == newOrder.sku);

      if (existingIndex != -1) {
        // SKU exists, update the quantity
        orders[existingIndex] = NewOrder(
            sku: orders[existingIndex].sku,
            quantity: orders[existingIndex].quantity + newOrder.quantity,
            discount: orders[existingIndex].discount,
            tax: orders[existingIndex].tax);
      } else {
        // SKU doesn't exist, add a new order
        orders.add(newOrder);
      }
    });
  }

  Future<bool> submitOrder() async {
    print(newOrderToJson(orders));
    BlocProvider.of<SalesBloc>(context).add(NewSalesInit());
    BlocProvider.of<SalesBloc>(context)
        .add(NewSale(payload: newOrderToJson(orders)));
    return true;
  }

  @override
  Widget build(BuildContext context) => NewSaleScreen(this);

  void removeOrderItem(NewOrder newOrder) {
    setState(() {
      // Check if the SKU already exists in the list
      int existingIndex =
          orders.indexWhere((order) => order.sku == newOrder.sku);

      if (existingIndex != -1) {
        // SKU exists, update the quantity
        orders.removeWhere((order) => order.sku == newOrder.sku);
      } else {
        // SKU doesn't exist, add a new order
        orders.add(newOrder);
      }
    });
  }

  void resetDialog() {
    qtyController.text = "";
    discountController.text = "0.0";
    taxController.text = "0.0";
  }
}
