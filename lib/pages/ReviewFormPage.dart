import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookbuddies/models/Review/review_model.dart';
import 'package:bookbuddies/providers/review_provider.dart';

class ReviewFormPage extends StatefulWidget {
  final int bookId;

  ReviewFormPage({required this.bookId});

  @override
  _ReviewFormPageState createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController judulController = TextEditingController();
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Form - Book ${widget.bookId}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Review',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please share your experience with us',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
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
                // Add your logic to handle the form submission
                // Access the values and widget.bookId for the specific book
                var name = nameController.text;
                var judul =
                    judulController.text; // Add this line to get the judul
                var reviewText = reviewController.text;

                // Add the review to the provider
                var reviewProvider = context.read<ReviewProvider>();
                reviewProvider.addReview(
                    Review(name: name, judul: judul, review: reviewText));

                // Navigate to the ReviewPage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewPage(),
                  ),
                );
                // You can use these values along with widget.bookId for further processing
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 106, 24, 18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                // Add your logic to handle cancel or navigate back
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 30, 78, 118)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
