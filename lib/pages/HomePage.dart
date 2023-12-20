import 'package:bookbuddies/models/Book/Book.dart';
import 'package:bookbuddies/models/User/User.dart';
import 'package:bookbuddies/pages/DetailBookPage.dart';
import 'package:bookbuddies/pages/MainPage.dart';
import 'package:bookbuddies/pages/ProfilePage.dart';
import 'package:bookbuddies/services/providers/Book/Book.dart';
import 'package:bookbuddies/services/providers/User/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int itemsPerPage = 10;
  PageController pageController = PageController();
  final PageController bookPageController = PageController();
  final BookProvider bookProvider = BookProvider();
  final UserProvider userProvider = UserProvider();

  late TextEditingController searchController;

  int currentPage = 0;
  List<Book> books = [];
  final String? imageURL = dotenv.env['IMAGE_URL'];
  String username = "";
  bool isAscending = true;

  int selectedIndex = 0;

  List<Widget> screens = [
    const HomePage(),
    const HomePage(),
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
    searchController = TextEditingController();
    pageController = PageController(
      initialPage: selectedIndex,
    );
  }

  Future<void> fetchData() async {
    try {
      final List<Book> fetchedBooks = await bookProvider.fetchBooks(
          currentPage + 1, itemsPerPage, 'title', isAscending ? 'asc' : 'desc');
      final User user = await userProvider.getUserProfile();
      setState(() {
        books = fetchedBooks;
        username = user.username;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future<void> performSearch(String query) async {
    try {
      final List<Book> searchedBooks = await bookProvider.searchBooks(query);
      setState(() {
        books = searchedBooks;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _toggleSortOrder() {
    setState(() {
      isAscending = !isAscending;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011D5B),
        leading: Container(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: GestureDetector(
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainPage(sIndex: 3)),
              )
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage('https://picsum.photos/200/300'),
            ),
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(right: 4, left: 4, bottom: 4),
          child: SearchBar(
            controller: searchController,
            leading: Icon(Icons.search),
            hintText: 'Search books',
            onChanged: (query) {
              performSearch(query);
            },
          ),
        ),
        actions: const <Widget>[],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 17.0, right: 17.0, top: 17.0, bottom: 10.0),
              child: Column(
                children: [
                  Text(
                    'Selamat Datang ${username}!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  SegmentedButton<bool>(
                    segments: const <ButtonSegment<bool>>[
                      ButtonSegment<bool>(
                          value: true,
                          label: Text('Ascending'),
                          icon: Icon(CupertinoIcons.sort_up)),
                      ButtonSegment<bool>(
                          value: false,
                          label: Text('Descending'),
                          icon: Icon(CupertinoIcons.sort_down)),
                    ],
                    selected: <bool>{isAscending},
                    onSelectionChanged: (Set<bool> newSelection) {
                      setState(() {
                        _toggleSortOrder();
                      });
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: PageView.builder(
                controller: bookPageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                    fetchData();
                  });
                },
                itemCount: (100 / itemsPerPage).ceil(),
                itemBuilder: (context, pageIndex) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BookDetailPage(bookId: book.id),
                            ),
                          );
                        },
                        child: Card(
                          semanticContainer: true,
                          color: const Color(0xFF5B011B),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            width: 200.0,
                            height: 300.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 120,
                                  child: Image.network(
                                    '$imageURL${book.isbn}-S.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: Text(
                                    book.title.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: currentPage != 0
                      ? () => {
                            bookPageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            )
                          }
                      : null,
                  child: const Icon(Icons.chevron_left),
                ),
                const SizedBox(width: 16),
                Text('Page ${currentPage + 1}'),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: (currentPage != (100 / itemsPerPage).ceil() - 1)
                      ? () => {
                            bookPageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            )
                          }
                      : null,
                  child: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
