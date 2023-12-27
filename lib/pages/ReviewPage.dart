import 'package:bookbuddies/models/Book/books.dart';
import 'package:bookbuddies/pages/BookReview.dart';
import 'package:bookbuddies/pages/CreateReview.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Book>> fetchProducts(request) async {
    var response = await request.get(
      'http://127.0.0.1:8000/review/get_all_books/',
    );

    List<Book> books = [];
    for (var d in response) {
      if (d != null) {
        books.add(Book.fromJson(d));
      }
    }
    return books;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Review Page'),
          backgroundColor: const Color(0xFF011D5B),
          foregroundColor: Colors.white,
        ),
        body: FutureBuilder(
            future: fetchProducts(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return const Column(
                    children: [
                      Text(
                        "Tidak ada data produk.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data![index].fields.title}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text("${snapshot.data![index].fields.authors}"),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: width * 0.5,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          child: const Text(
                                            'See Reviews',
                                            style: TextStyle(
                                              fontSize: 10, // Font size
                                              fontWeight: FontWeight
                                                  .bold, // Font weight
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookReviewPage(snapshot
                                                          .data![index])),
                                            );
                                          })),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: width * 0.5,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          child: const Text(
                                            'Create Review',
                                            style: TextStyle(
                                              fontSize: 10, // Font size
                                              fontWeight: FontWeight
                                                  .bold, // Font weight
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CreateReviewPage(snapshot
                                                          .data![index])),
                                            );
                                          })),
                                ),
                              ],
                            ),
                          ));
                }
              }
            }));
  }
}
