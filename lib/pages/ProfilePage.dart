import 'package:bookbuddies/pages/LoginPage.dart';
import 'package:bookbuddies/pages/ListLoanBookPage.dart'; // Import halaman ListLoanBookPage.dart
import 'package:flutter/material.dart';
import 'package:bookbuddies/models/User/User.dart';
import 'package:bookbuddies/services/providers/User/User.dart';
import 'package:bookbuddies/pages/ListLoanBookPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserProvider userProvider = UserProvider();

  String username = "Not set";
  final String imageURL = 'https://picsum.photos/200/300';
  String email = "Not set";
  String phone = "Not set";

  @override
  void initState() {
    super.initState();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      User userProfile = await userProvider.getUserProfile();
      debugPrint(userProfile.toString());
      setState(() {
        username = userProfile.username;
        email = userProfile.email;
      });
    } catch (e) {
      debugPrint('Error loading user profile: $e');
    }
  }

  // Function to show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah anda yakin untuk logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await userProvider.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF011D5B),
        foregroundColor: Colors.white,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: Column(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(imageURL),
            ),
            const SizedBox(height: 16.0),

            // Name
            Text(
              username,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // Bio
            Text(
              email,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24.0),

            Container(
              width: double.infinity,
              color: Color(0xFF5B011B),
              padding:
                  EdgeInsets.only(left: 17, right: 17, top: 12.5, bottom: 12.5),
              child: Text(
                'General Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: Text('Edit Profile'),
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: Text('Change Password'),
              trailing: const Icon(Icons.chevron_right),
            ),
            Container(
              width: double.infinity,
              color: Color(0xFF5B011B),
              padding:
                  EdgeInsets.only(left: 17, right: 17, top: 12.5, bottom: 12.5),
              child: Text(
                'Information',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.library_books), // Ikonya bisa disesuaikan
              title: Text(
                'Buku yang dipinjam',
                // Gaya teks atau warna ikonya bisa disesuaikan
              ),
              onTap: () {
                // Tambahkan navigasi ke halaman ListLoanBookPage.dart di sini
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ListLoanBookPage(), // Ganti dengan nama halaman yang sesuai
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF5B011B)),
              title: Text(
                'Log out',
                style: TextStyle(color: Color(0xFF5B011B)),
              ),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
