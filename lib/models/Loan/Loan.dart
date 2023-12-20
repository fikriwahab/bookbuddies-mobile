// To parse this JSON data, do
//
//     final loan = loanFromJson(jsonString);

import 'dart:convert';

List<Loan> loanFromJson(String str) =>
    List<Loan>.from(json.decode(str).map((x) => Loan.fromJson(x)));

String loanToJson(List<Loan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Loan {
  Model model;
  int pk;
  Fields fields;

  Loan({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  int book;
  int? user;
  String name;
  DateTime dueDate;
  String address;

  Fields({
    required this.book,
    required this.user,
    required this.name,
    required this.dueDate,
    required this.address,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        book: json["book"],
        user: json["user"],
        name: json["name"],
        dueDate: DateTime.parse(json["due_date"]),
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "book": book,
        "user": user,
        "name": name,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "address": address,
      };
}

enum Model { HALAMAN_INFORMASI_BUKU_LOAN }

final modelValues = EnumValues(
    {"HalamanInformasiBuku.loan": Model.HALAMAN_INFORMASI_BUKU_LOAN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
