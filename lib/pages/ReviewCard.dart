// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:convert';
import 'package:bookbuddies/models/Book/books.dart';
import 'package:bookbuddies/models/Review/Review.dart';
import 'package:bookbuddies/pages/EditReview.dart';
import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard(this.review, {super.key});

  Future<Book> fetchBook(request) async {
    var response = await request.postJson(
        "http://127.0.0.1:8000/review/get_book/",
        jsonEncode(<String, String>{
          'pk': review.fields.book.toString(),
        }));

    return Book.fromJson(response.first);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10.0,
      child: InkWell(
          onTap: () async {
            showReview(context, request);
          },
          child: FutureBuilder<Book>(
              future: fetchBook(request),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: screenWidth * 0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.3,
                            child: Column(children: [
                              Text(
                                snapshot.data!.fields.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Rating: ${review.fields.rating} / 5",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.05),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditReviewPage(snapshot.data!, review),
                                              ));
                                        },
                                        child: const Text("Edit Review")),
                                  ),
                                  SizedBox(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await request.postJson(
                                              "http://127.0.0.1:8000/review/delete_review_flutter/",
                                              jsonEncode(<String, String>{
                                                'review_id':
                                                    review.pk.toString(),
                                              }));

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ReviewPage(),
                                              ));
                                        },
                                        child: const Text("Delete Review")),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  );
                }
              })),
    );
  }

  void showReview(BuildContext context, request) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          // height: screenHeight * 0.6,
          width: screenWidth * 0.8,
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Column(
              children: [
                PreferredSize(
                  preferredSize: Size.fromHeight(
                      screenHeight * 0.1), // Define the height of the AppBar
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                          10.0), // Define the radius for the top left corner
                      topRight: Radius.circular(
                          10.0), // Define the radius for the top right corner
                    ),
                    child: AppBar(
                      backgroundColor: const Color(0xFF011D5B),
                      foregroundColor: Colors.white,
                      title: const Text("Review"),
                      // Other AppBar properties
                    ),
                  ),
                ),
                FutureBuilder<Book>(
                    future: fetchBook(request),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data!.fields.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Rating: ${review.fields.rating} / 5",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Container(
                                  alignment: Alignment.topCenter,
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.5,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      review.fields.review,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.02),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditReviewPage(snapshot.data!, review),
                                              ));
                                          },
                                          child: const Text("Edit Review")),
                                    ),
                                    SizedBox(
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            await request.postJson(
                                                "http://127.0.0.1:8000/review/delete_review_flutter/",
                                                jsonEncode(<String, String>{
                                                  'review_id':
                                                      review.pk.toString(),
                                                }));

                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ReviewPage(),
                                                ));
                                          },
                                          child: const Text("Delete Review")),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
