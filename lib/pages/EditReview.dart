// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'package:bookbuddies/models/Book/books.dart';
import 'package:bookbuddies/models/Review/Review.dart';
import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class EditReviewPage extends StatefulWidget {
  final Book book;
  final Review review;

  const EditReviewPage(this.book, this.review, {super.key});

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> score = [
    "--",
    "1",
    "2",
    "3",
    "4",
    "5",
  ];
  late TextEditingController _review;
  late TextEditingController _rating;

  @override
  void initState() {
    super.initState();
    _review = TextEditingController(text: widget.review.fields.review);
    _rating = TextEditingController(text: "${widget.review.fields.rating}");
  }

  @override
  void dispose() {
    _review.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011D5B),
        foregroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Edit Review',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.book.fields.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField<String>(
                          value: _rating.text, // Set the initial value
                          decoration: const InputDecoration(
                            labelText: "Rate this book...",
                            alignLabelWithHint: true,
                          ),
                          items: score
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _rating.text = newValue ??
                                  ""; // Update the controller's value
                            });
                          },
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value == "--") {
                              return "Rate this book!";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _review,
                          decoration: const InputDecoration(
                            labelText: "Write your review here...",
                            alignLabelWithHint: true,
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Review cannot be empty!";
                            }
                            return null;
                          },
                          maxLines: 20,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              child: const Text(
                                'Edit Review',
                                style: TextStyle(
                                  fontSize: 18, // Font size
                                  fontWeight: FontWeight.bold, // Font weight
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final response = await request.postJson(
                                      "http://127.0.0.1:8000/review/edit_review_flutter/",
                                      jsonEncode(<String, String>{
                                        'review_id':
                                            widget.review.pk.toString(),
                                        'rating': _rating.text,
                                        'review': _review.text,
                                      }));
                                  if (response['status'] == true) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReviewPage()),
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
