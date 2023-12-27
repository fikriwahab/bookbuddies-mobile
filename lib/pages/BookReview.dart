// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'dart:convert';

import 'package:bookbuddies/models/Book/books.dart';
import 'package:bookbuddies/models/Review/Review.dart';
import 'package:bookbuddies/pages/ReviewCard.dart';
import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookReviewPage extends StatefulWidget {
  final Book book;
  const BookReviewPage(this.book, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BookReviewPageState createState() => _BookReviewPageState();
}

class _BookReviewPageState extends State<BookReviewPage> {
  Future<List<Review>> fetchBookReview(request) async {
    var response = await request.postJson(
        "http://127.0.0.1:8000/review/book_reviews/",
        jsonEncode(<String, String>{
          'pk': widget.book.pk.toString(),
        }));

    List<Review> listBookReview = [];
    for (var d in response) {
      if (d != null) {
        listBookReview.add(Review.fromJson(d));
      }
    }
    return listBookReview;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Review ${widget.book.fields.title.length > 30 ? "${widget.book.fields.title.substring(0, 30)}..." : widget.book.fields.title}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF011D5B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: width * 0.05),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<List<Review>>(
                future: fetchBookReview(request),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (!snapshot.hasData ||
                      snapshot.data!.isEmpty ||
                      snapshot.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ReviewPage(),
                                  ));
                            },
                            child: const Text(
                              'Back to Reviews',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2 / 1,
                      ),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ReviewCard(snapshot.data![index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
