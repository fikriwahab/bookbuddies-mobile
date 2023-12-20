import 'package:bookbuddies/pages/BookmarkPage.dart';
import 'package:bookbuddies/pages/HomePage.dart';
import 'package:bookbuddies/pages/ProfilePage.dart';
import 'package:bookbuddies/pages/ReviewPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      // Redirect to login page or handle the scenario when the user is not logged in
      // For now, let's redirect to the login page
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
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
