import 'package:flutter/material.dart';

class ReviewFormPage extends StatefulWidget {
  final int bookId;

  ReviewFormPage({required this.bookId});

  @override
  _ReviewFormPageState createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController returnDateController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
              controller: returnDateController,
              decoration: InputDecoration(
                labelText: 'Return Date',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Add your logic to handle the form submission
                // Access the values and widget.bookId for the specific book
                var name = nameController.text;
                var returnDate = returnDateController.text;
                var address = addressController.text;
                // You can use these values along with widget.bookId for further processing
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
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
                side: BorderSide(color: Colors.blue),
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
