// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String name;
  DateTime dueDate;
  String address;

  Product({
    required this.name,
    required this.dueDate,
    required this.address,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        dueDate: DateTime.parse(json["due_date"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "address": address,
      };
}
