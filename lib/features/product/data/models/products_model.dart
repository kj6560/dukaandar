import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  int id;
  int orgId;
  String name;
  String sku;
  double productMrp;
  int isActive;
  String createdAt;
  String updatedAt;

  Product({
    required this.id,
    required this.orgId,
    required this.name,
    required this.sku,
    required this.productMrp,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        orgId: json['org_id'],
        productMrp: double.parse(json['product_mrp'].toString()),
        sku: json['sku'],
        isActive: json['is_active'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'org_id': orgId,
      'productMrp': productMrp,
      'sku': sku,
      'is_active': isActive,
      'created_at': createdAt,
      'updated_a': updatedAt
    };
  }
}
