import 'package:bookbuddies/models/Book/Book.dart';
import 'package:bookbuddies/services/providers/Book/Book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookbuddies/providers/bookmark_provider.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  @override
  Widget build(BuildContext context) {
    final bookmarkProvider = Provider.of<BookmarkProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011D5B),
        foregroundColor: Colors.white,
        title: const Text('Bookmarked Books'),
      ),
      body: bookmarkProvider.bookmarks.isEmpty
          ? const Center(
              child: Text(
                "You haven't bookmarked any books yet",
                style: TextStyle(
                  color: Color(0xFF5B011B),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: bookmarkProvider.bookmarks.length,
              itemBuilder: (context, index) {
                final bookId = bookmarkProvider.bookmarks[index];
                return FutureBuilder<Book>(
                  future: BookProvider().fetchBookDetails(bookId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData) {
                      return Text('No data available');
                    } else {
                      final Book book = snapshot.data!;
                      return Card(
                        // You can customize the appearance of the card here
                        elevation: 3,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text(book.title),
                          subtitle: Text(book.authors),
                          // ... add more details if needed
                        ),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}
