part of new_sale_library;

class NewSaleScreen extends WidgetView<NewSaleScreen, NewSaleControllerState> {
  NewSaleScreen(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Sale", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
        elevation: 0,
        // Remove shadow
        automaticallyImplyLeading: false,
        leading: Image.asset("assets/launcher_icon.png"),

        actions: <Widget>[
          PopupMenuButton<String>(
            iconColor: Colors.white,
            onSelected: (String result) {
              // Handle the selected action
              if (result == 'Option 1') {
                // Perform action 1
                print('Option 1 selected');
              } else if (result == 'Option 2') {
                // Perform action 2
                print('Option 2 selected');
              } else if (result == 'Option 3') {
                print('Option 3 selected');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Option 1'),
              ),
              const PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Option 2'),
              ),
              const PopupMenuItem<String>(
                value: 'Option 3',
                child: Text('Option 3'),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<SalesBloc, SalesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NewSalesSuccess) {
            return Container(
              child: Center(
                child: Column(
                  children: [
                    Text("New Order Recorded!"),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Back'))
                  ],
                ),
              ),
            );
          } else if (state is NewSalesFailure) {
            _showOrderDialog(context, 2);
          }

          return Container(
            child: Form(
              key: controllerState.formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          String scannedSKU =
                              await controllerState.scanBarcode();
                          if (scannedSKU.isNotEmpty) {
                            _showQuantityDialog(context, scannedSKU);
                            //
                          }
                        },
                        child: Text('Scan Barcode',
                            style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controllerState.orders.length,
                        itemBuilder: (context, index) {
                          NewOrder newOrder = controllerState.orders[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Sku: ${newOrder.sku}'),
                                      Text('Qty: ${newOrder.quantity}'),
                                      Text('Discount: ${newOrder.discount}'),
                                      SizedBox(
                                        width: 50,
                                        child: InkWell(
                                          child: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                          onTap: () {
                                            controllerState
                                                .removeOrderItem(newOrder);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          controllerState.submitOrder();
                        },
                        child: Text('Submit', style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showQuantityDialog(BuildContext context, String sku) async {
    // Default quantity

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        controllerState.resetDialog();
        return AlertDialog(
          title: Text("Fill the details"),
          content: SizedBox(
            height: 230,
            child: Column(
              children: [
                TextField(
                  controller: controllerState.qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controllerState.discountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Discount",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: controllerState.taxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Tax",
                    border: OutlineInputBorder(),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                double quantity =
                    double.tryParse(controllerState.qtyController.text) ??
                        1; // Validate input
                double discount =
                    double.parse(controllerState.discountController.text) ??
                        0.0;
                double tax = double.parse(controllerState.taxController.text);
                if (quantity > 0) {
                  NewOrder newOrder = NewOrder(
                      sku: sku,
                      quantity: quantity,
                      discount: discount,
                      tax: tax);
                  controllerState.updateOrder(newOrder);
                  print(controllerState.orders.length);
                  Navigator.of(context).pop(); // Close dialog
                }
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showOrderDialog(BuildContext context, int type) async {
    // Default quantity

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New Order"),
          content: Container(
            child: Column(
              children: [
                Text(type == 1 ? "Order recorded!!" : "Failed To Record Order")
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
