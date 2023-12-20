import 'package:bookbuddies/models/Review/review_model.dart';
import 'package:bookbuddies/pages/EditReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookbuddies/providers/review_provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    var reviewProvider = context.watch<ReviewProvider>();
    var reviews = reviewProvider.reviews;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011D5B),
        foregroundColor: Colors.white,
        title: const Text('Review'),
      ),
      body: reviews.isNotEmpty
          ? ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                var review = reviews[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(review.judul),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review.name),
                        Text(review.review),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Tampilkan dialog atau navigasi ke halaman edit review
                            // Pass review dan index ke halaman edit
                            _navigateToEditReview(context, review, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Hapus review
                            reviewProvider.deleteReview(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                "Anda belum pernah membuat review",
                style: TextStyle(
                  color: Color(0xFF5B011B),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  // Fungsi untuk navigasi ke halaman edit review
  void _navigateToEditReview(BuildContext context, Review review, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReviewPage(review: review, index: index),
      ),
    );
  }
}
