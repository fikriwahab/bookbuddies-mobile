import 'package:flutter/material.dart';
import 'package:bookbuddies/models/Book/Book.dart';
import 'package:bookbuddies/pages/BorrowFormPage.dart';
import 'package:bookbuddies/pages/ReviewFormPage.dart';
import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:bookbuddies/services/providers/Book/Book.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bookbuddies/providers/bookmark_provider.dart';

class BookDetailPage extends StatefulWidget {
  final int bookId;
  final BookProvider bookProvider = BookProvider();
  final String? imageURL = dotenv.env['IMAGE_URL'];

  BookDetailPage({required this.bookId});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool isBookmarked = false;
  late BookmarkProvider bookmarkProvider;

  // Fungsi untuk menyimpan status bookmark ke SharedPreferences
  Future<void> saveBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('bookmark_${widget.bookId}', isBookmarked);
  }

  // Fungsi untuk membaca status bookmark dari SharedPreferences
  Future<void> readBookmarkStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? bookmarkStatus = prefs.getBool('bookmark_${widget.bookId}');
    if (bookmarkStatus != null) {
      setState(() {
        isBookmarked = bookmarkStatus;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    bookmarkProvider = context.read<BookmarkProvider>();
    // Panggil fungsi untuk membaca status bookmark saat halaman dibuat
    readBookmarkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Book>(
      future: widget.bookProvider.fetchBookDetails(widget.bookId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF011D5B),
              foregroundColor: Colors.white,
              title: Text(
                'Loading...',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF011D5B),
              foregroundColor: Colors.white,
              title: Text(
                'Error',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF011D5B),
              foregroundColor: Colors.white,
              title: Text(
                'Error',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Center(
              child: Text('No data available'),
            ),
          );
        } else {
          final Book book = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF011D5B),
              foregroundColor: Colors.white,
              title: SizedBox(
                width: 300,
                child: Text(
                  '${book.title}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  textWidthBasis: TextWidthBasis.parent,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          '${widget.imageURL}${book.isbn}-L.jpg',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '${book.title}',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: Divider(),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 5.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      'Book Information',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Author: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.authors}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'ISBN: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.isbn}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'ISBN13: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.isbn13}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Number of pages: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.numPages}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Text Review Count: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.textReviewCount}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Publication Date: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.publicationDate}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 17.0,
                      right: 17.0,
                      top: 10.0,
                      bottom: 10.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Text(
                            'Publisher: ',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Text(
                            '${book.publisher}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Borrow Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the borrowing form page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BorrowFormPage(
                            bookId: widget.bookId,
                          ),
                        ),
                      );
                    },
                    child: Text('Pinjam', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Set the button color
                    ),
                  ),

                  // Add space between buttons
                  SizedBox(width: 10),

                  // Bookmark Button
                  ElevatedButton(
                    onPressed: () {
                      // Toggle status bookmark
                      setState(() {
                        isBookmarked = !isBookmarked;
                      });

                      // Tambahkan atau hapus buku dari daftar bookmark
                      if (isBookmarked) {
                        bookmarkProvider.addBookmark(widget.bookId);
                      } else {
                        bookmarkProvider.removeBookmark(widget.bookId);
                      }

                      // Simpan status bookmark ke SharedPreferences
                      saveBookmarkStatus();
                    },
                    child: Text(
                      isBookmarked ? 'Bookmarked' : 'Bookmark',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 25, 71, 109),
                    ),
                  ),

                  // Add space between buttons
                  SizedBox(width: 10),

                  // Review Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the review form page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewFormPage(
                            bookId: widget.bookId,
                          ),
                        ),
                      );
                    },
                    child: Text('Review', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 25, 71, 109),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
