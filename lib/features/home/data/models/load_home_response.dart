class HomeKpiResponse {
  Sales sales;
  Inventory inventory;
  Products products;

  HomeKpiResponse({
    required this.sales,
    required this.inventory,
    required this.products,
  });

  factory HomeKpiResponse.fromJson(Map<String, dynamic> json) {
    return HomeKpiResponse(
      sales: Sales.fromJson(json['sales']),
      inventory: Inventory.fromJson(json['inventory']),
      products: Products.fromJson(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sales': sales.toJson(),
      'inventory': inventory.toJson(),
      'products': products.toJson(),
    };
  }
}

class Inventory {
  int inventoryAddedToday;
  int inventoryAddedThisMonth;
  int inventoryAddedTotal;

  Inventory({
    required this.inventoryAddedToday,
    required this.inventoryAddedThisMonth,
    required this.inventoryAddedTotal,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      inventoryAddedToday: json['inventory_added_today'],
      inventoryAddedThisMonth: json['inventory_added_this_month'],
      inventoryAddedTotal: json['inventory_added_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'inventoryAddedToday': inventoryAddedToday,
      'inventoryAddedThisMonth': inventoryAddedThisMonth,
      'inventoryAddedTotal': inventoryAddedTotal,
    };
  }
}

class Products {
  int productsAddedToday;
  int productsAddedThisMonth;
  int productsAddedTotal;

  Products({
    required this.productsAddedToday,
    required this.productsAddedThisMonth,
    required this.productsAddedTotal,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      productsAddedToday: json['products_added_today'],
      productsAddedThisMonth: json['products_added_this_month'],
      productsAddedTotal: json['products_added_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productsAddedToday': productsAddedToday,
      'productsAddedThisMonth': productsAddedThisMonth,
      'productsAddedTotal': productsAddedTotal,
    };
  }
}

class Sales {
  String salesToday;
  String salesThisMonth;
  String salesTotal;

  Sales({
    required this.salesToday,
    required this.salesThisMonth,
    required this.salesTotal,
  });

  factory Sales.fromJson(Map<String, dynamic> json) {
    return Sales(
      salesToday: json['sales_today'],
      salesThisMonth: json['sales_this_month'],
      salesTotal: json['sales_total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salesToday': salesToday,
      'salesThisMonth': salesThisMonth,
      'salesTotal': salesTotal,
    };
  }
}
