import 'package:bookbuddies/models/Book/Book.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BookProvider {
  final Dio dio = Dio();

  Future<List<Book>> fetchBooks(
      int page, int show, String? sort_by, String? order) async {
    try {
      await dotenv.load();
      final String apiUrl = dotenv.env['API_URL'] ?? '';
      final response = await dio.get(
        '$apiUrl/api/book_list/',
        queryParameters: {
          'show': show,
          'page': page,
          'sort_by': sort_by,
          'order': order,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = List.from(response.data['books']);
        final List<Book> books = parseBooks(data);
        return books;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      debugPrint('Error: $error');
      throw error;
    }
  }

  Future<Book> fetchBookDetails(int bookId) async {
    try {
      await dotenv.load();
      final String apiUrl = dotenv.env['API_URL'] ?? '';
      final response = await dio.get('$apiUrl/api/book/$bookId/');

      if (response.statusCode == 200) {
        return Book.fromJson(response.data);
      } else {
        throw Exception('Failed to load book details');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<Book>> searchBooks(String query) async {
    try {
      await dotenv.load();
      final String apiUrl = dotenv.env['API_URL'] ?? '';
      final response =
          await dio.get('$apiUrl/api/search/', queryParameters: {'query': query});

      if (response.statusCode == 200) {
        final List<dynamic> data = List.from(response.data['books']);
        final List<Book> books = parseBooks(data);
        return books;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      debugPrint('Error: $error');
      throw error;
    }
  }

  List<Book> parseBooks(List<dynamic> data) {
    return data.map((bookData) => Book.fromJson(bookData)).toList();
  }
}
