import 'package:bookbuddies/pages/BookmarkPage.dart';
import 'package:bookbuddies/pages/HomePage.dart';
import 'package:bookbuddies/pages/ProfilePage.dart';
import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final int sIndex;
  const MainPage({Key? key, this.sIndex = 0}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int selectedIndex = widget.sIndex;
  PageController pageController = PageController();
  List<Widget> screens = [
    const HomePage(),
    const BookmarkPage(),
    const ReviewPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  void initState() {
    selectedIndex = widget.sIndex;
    pageController = PageController(
      initialPage: selectedIndex,
    );
    debugPrint(widget.sIndex.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: screens.length,
        onPageChanged: (newPage) {
          setState(() {
            selectedIndex = newPage;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return screens[index];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF011D5B),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
            backgroundColor: Color(0xFF011D5B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: 'Bookmark',
            backgroundColor: Color(0xFF011D5B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reviews),
            label: 'Review',
            backgroundColor: Color(0xFF011D5B),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Color(0xFF011D5B),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
    );
  }
}
