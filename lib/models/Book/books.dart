// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
    String model;
    int pk;
    Fields fields;

    Book({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String title;
    String authors;
    double averageRating;
    String isbn;
    String isbn13;
    String languageCode;
    int numPages;
    int ratingsCount;
    int textReviewCount;
    dynamic publicationDate;
    String publisher;
    String cover;

    Fields({
        required this.title,
        required this.authors,
        required this.averageRating,
        required this.isbn,
        required this.isbn13,
        required this.languageCode,
        required this.numPages,
        required this.ratingsCount,
        required this.textReviewCount,
        required this.publicationDate,
        required this.publisher,
        required this.cover,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        authors: json["authors"],
        averageRating: json["average_rating"]?.toDouble(),
        isbn: json["isbn"],
        isbn13: json["isbn13"],
        languageCode: json["language_code"],
        numPages: json["num_pages"],
        ratingsCount: json["ratings_count"],
        textReviewCount: json["text_review_count"],
        publicationDate: json["publication_date"],
        publisher: json["publisher"],
        cover: json["cover"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "authors": authors,
        "average_rating": averageRating,
        "isbn": isbn,
        "isbn13": isbn13,
        "language_code": languageCode,
        "num_pages": numPages,
        "ratings_count": ratingsCount,
        "text_review_count": textReviewCount,
        "publication_date": publicationDate,
        "publisher": publisher,
        "cover": cover,
    };
}
