part of home_library;

class HomeScreenUI extends WidgetView<HomeScreenUI, HomeScreenControllerState> {
  HomeScreenUI(super.controllerState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dukaandar", style: TextStyle(color: Colors.white)),
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
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          controllerState.handleApiResponse(state);
        }, builder: (context, state) {
          if (state is LoadHomeFailure) {
            return Container(
              child: Center(
                child: Text(state.error),
              ),
            );
          } else if (state is LoadHomeSuccess) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            child: CircularCard(
                              diameter: 70.0,
                              color: Colors.teal, // Optional background color
                              child: Icon(Icons.new_label_rounded,
                                  size: 50.0, color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.listSales);
                            },
                          ),
                          Text(
                            "Order",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            child: CircularCard(
                              diameter: 70.0,
                              color: Colors.teal, // Optional background color
                              child: Icon(Icons.inventory,
                                  size: 50.0, color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.listInventory);
                            },
                          ),
                          Text(
                            "Inventory",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            child: CircularCard(
                              diameter: 70.0,
                              color: Colors.teal, // Optional background color
                              child: Icon(Icons.next_week_rounded,
                                  size: 50.0, color: Colors.white),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.listProduct);
                            },
                          ),
                          Text(
                            "Product",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "SALES",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Today: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.sales.salesToday}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Monthly: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.sales.salesThisMonth}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.teal,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Total: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.sales.salesTotal}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "INVENTORY",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Today: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.inventory.inventoryAddedToday}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Monthly: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.inventory.inventoryAddedThisMonth}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.teal,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Total: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.inventory.inventoryAddedTotal}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "PRODUCTS",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Today: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.products.productsAddedToday}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Monthly: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.products.productsAddedThisMonth}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1,
                              child: Container(
                                color: Colors.teal,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Total: ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(
                                  Icons.currency_rupee,
                                  size: 14,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "${state.response.products.productsAddedTotal}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          }
        }),
      ),
    );
  }
}
