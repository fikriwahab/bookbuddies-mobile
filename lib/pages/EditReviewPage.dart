import 'package:bookbuddies/models/Review/review_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookbuddies/providers/review_provider.dart';

class EditReviewPage extends StatefulWidget {
  final Review review;
  final int index;

  EditReviewPage({required this.review, required this.index});

  @override
  _EditReviewPageState createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.review.name;
    judulController.text = widget.review.judul;
    reviewController.text = widget.review.review;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: judulController,
              decoration: InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: reviewController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Review',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Simpan review yang telah diedit
                var newName = nameController.text;
                var newJudul = judulController.text;
                var newReviewText = reviewController.text;

                var editedReview = Review(
                    name: newName, judul: newJudul, review: newReviewText);

                // Panggil metode untuk mengedit review pada ReviewProvider
                var reviewProvider = context.read<ReviewProvider>();
                reviewProvider.editReview(widget.index, editedReview);

                // Kembali ke halaman ReviewPage setelah mengedit
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 106, 24, 18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
