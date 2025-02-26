part of new_product_library;

class NewProductScreen
    extends WidgetView<NewProductScreen, NewProductControllerState> {
  NewProductScreen(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Product", style: TextStyle(color: Colors.white)),
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
      body: SingleChildScrollView(
        child: Form(
          key: controllerState.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerState.nameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerState.priceController,
                  decoration: InputDecoration(
                    labelText: 'Enter Product Mrp',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product mrp';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: 150,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    controllerState.scanBarcode();
                  },
                  child: Text('Scan Barcode', style: TextStyle(fontSize: 18)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controllerState.skuController,
                  decoration: InputDecoration(
                    labelText: 'Product Sku',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product SKU is required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    controllerState.createNewProduct();
                  },
                  child: Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
