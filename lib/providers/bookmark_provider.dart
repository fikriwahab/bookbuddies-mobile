import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkProvider extends ChangeNotifier {
  List<int> _bookmarks = [];

  List<int> get bookmarks => _bookmarks;

  Future<void> saveBookmarkStatus(int bookId, bool isBookmarked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bookmark_$bookId', isBookmarked);
  }

  Future<bool> readBookmarkStatus(int bookId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('bookmark_$bookId') ?? false;
  }

  void addBookmark(int bookId) {
    if (!_bookmarks.contains(bookId)) {
      _bookmarks.add(bookId);
      notifyListeners();
    }
  }

  void removeBookmark(int bookId) {
    _bookmarks.remove(bookId);
    notifyListeners();
  }
}
