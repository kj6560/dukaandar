part of sales_list_library;

class SalesListUi extends WidgetView<SalesListUi, SalesListControllerState> {
  SalesListUi(super.controllerState, {super.key});

  final List<String> items = List.generate(200, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales", style: TextStyle(color: Colors.white)),
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
          child: BlocConsumer<SalesBloc, SalesState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadSalesSuccess) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: state.response.length,
                      // Number of items in the list
                      itemBuilder: (context, index) {
                        SalesModel order = state.response[index];
                        return Container(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text("${order.orderId}")],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Amount: "),
                                            Icon(
                                              Icons.currency_rupee,
                                              size: 14,
                                            ),
                                            Text("${order.netTotal}")
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${order.orderDate}')
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is LoadSalesFailure) {
                  return Container();
                } else {
                  return Container();
                }
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.popAndPushNamed(context, AppRoutes.newSale);
        },
      ),
    );
  }
}
