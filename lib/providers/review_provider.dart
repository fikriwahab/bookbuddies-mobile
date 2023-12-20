// review_provider.dart
import 'package:bookbuddies/models/Review/review_model.dart';
import 'package:flutter/material.dart';
import 'package:bookbuddies/providers/review_provider.dart';

class ReviewProvider extends ChangeNotifier {
  List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  void addReview(Review review) {
    _reviews.add(review);
    notifyListeners();
  }

  void deleteReview(int index) {
    _reviews.removeAt(index);
    notifyListeners();
  }

  void editReview(int index, Review newReview) {
    _reviews[index] = newReview;
    notifyListeners();
  }
}
