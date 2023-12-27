import 'package:flutter/material.dart';

class Book {
  final int id;
  final String title;
  final String authors;
  final double? averageRating;
  final String? isbn;
  final String? isbn13;
  final String? languageCode;
  final int? numPages;
  final int? ratingsCount;
  final int? textReviewCount;
  final String? publicationDate;
  final String? publisher;
  final String? cover;

  Book({
    required this.id,
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

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      authors: json['authors'],
      averageRating: json['average_rating'],
      isbn: json['isbn'],
      isbn13: json['isbn13'],
      languageCode: json['language_code'],
      numPages: json['num_pages'],
      ratingsCount: json['ratings_count'],
      textReviewCount: json['text_review_count'],
      publicationDate: json['publication_date'] ?? "",
      publisher: json['publisher'],
      cover: json['cover'] ?? "",
    );
  }
}

List<Book> parseBooks(List<dynamic> responseBody) {
  try {
    List<Book> books =
        responseBody.map<Book>((json) => Book.fromJson(json)).toList();
    return books;
  } catch (e) {
    debugPrint('Error parsing books: $e');
    return [];
  }
}
