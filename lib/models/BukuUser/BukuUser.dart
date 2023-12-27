// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  List<BorrowedBook> borrowedBooks;

  Product({
    required this.borrowedBooks,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        borrowedBooks: List<BorrowedBook>.from(
            json["borrowed_books"].map((x) => BorrowedBook.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "borrowed_books":
            List<dynamic>.from(borrowedBooks.map((x) => x.toJson())),
      };
}

class BorrowedBook {
  String bookTitle;
  DateTime dueDate;
  String address;

  BorrowedBook({
    required this.bookTitle,
    required this.dueDate,
    required this.address,
  });

  factory BorrowedBook.fromJson(Map<String, dynamic> json) => BorrowedBook(
        bookTitle: json["book_title"],
        dueDate: DateTime.parse(json["due_date"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "book_title": bookTitle,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "address": address,
      };
}
