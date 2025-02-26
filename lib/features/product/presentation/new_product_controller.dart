library new_product_library;

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widget_view_base.dart';
import 'bloc/product_bloc.dart';

part 'new_product_screen.dart';

class NewProductController extends StatefulWidget {
  const NewProductController({super.key});

  @override
  State<NewProductController> createState() => NewProductControllerState();
}

class NewProductControllerState extends State<NewProductController> {
  String _scanBarcode = "";

  Future<void> scanBarcode() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      //Handle the scanned barcode result
      setState(() {
        _scanBarcode = barcodeScanRes;
        skuController.text = _scanBarcode;
      });
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController skuController = TextEditingController();

  @override
  Widget build(BuildContext context) => NewProductScreen(this);

  void createNewProduct() {
    if (formKey.currentState!.validate()) {
      var name = nameController.text.toString();
      var price = priceController.text.toString();
      var sku = skuController.text.toString();

      BlocProvider.of<ProductBloc>(context).add(
          AddNewProduct(sku: sku, name: name, price: double.tryParse(price)!));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form submitted successfully!')),
      );
    }
    print("submit linked to controller");
  }
}
