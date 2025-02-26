import 'dart:convert';

List<InventoryModel> inventoryModelFromJson(String str) =>
    List<InventoryModel>.from(
        json.decode(str).map((x) => InventoryModel.fromJson(x)));

String inventoryModelToJson(List<InventoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InventoryModel {
  int id;
  int orgId;
  int productId;
  double quantity;
  double balanceQuantity;
  String name;
  double productMrp;
  int isActive;

  InventoryModel({
    required this.id,
    required this.orgId,
    required this.productId,
    required this.quantity,
    required this.balanceQuantity,
    required this.name,
    required this.productMrp,
    required this.isActive,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
        id: json['id'],
        orgId: json['org_id'],
        productId: json['product_id'],
        quantity: double.parse(json['quantity'].toString()),
        balanceQuantity: double.parse(json['balance_quantity'].toString()),
        name: json['name'],
        productMrp: double.parse(json['product_mrp'].toString()),
        isActive: json['is_active']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'org_id': orgId,
      'product_mrp': productMrp,
      'quantity': quantity,
      'balance_quantity': balanceQuantity,
      'is_active': isActive
    };
  }
}
