import 'package:bookbuddies/models/User/User.dart';
import 'package:bookbuddies/pages/ForgotPasswordPage.dart';
import 'package:bookbuddies/pages/MainPage.dart';
import 'package:bookbuddies/pages/RegisterPage.dart';
import 'package:bookbuddies/services/providers/User/User.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final UserProvider userProvider = UserProvider();
  bool _isPasswordObscured = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.0),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Color(0xFF5B011B),
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(text: 'Book'),
                  TextSpan(
                    text: 'Buddies',
                    style: TextStyle(
                      color: Color(0xFF011D5B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                fillColor: Color(0xFF011D5B),
                filled: true,
                hintStyle: TextStyle(color: Colors.white),
                counterStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: _isPasswordObscured,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                fillColor: Color(0xFF011D5B),
                filled: true,
                hintStyle: TextStyle(color: Colors.white),
                counterStyle: TextStyle(color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                bool loginSuccess = await userProvider.login(
                  _usernameController.text,
                  _passwordController.text,
                );

                if (loginSuccess) {
                  User loggedUser = await userProvider.getUserProfile();

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('username', loggedUser.username);
                  prefs.setBool('isLoggedIn', true);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                            "Login Sukses! Selamat datang, ${loggedUser.username}."),
                      ),
                    );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login Gagal'),
                      content:
                          Text('Login gagal! username atau password salah.'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 16.0),
            InkWell(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Color(0xFF5B011B),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPage(),
                  ),
                )
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    color: Color(0xFF5B011B),
                    fontSize: 21,
                  ),
                ),
                SizedBox(width: 4),
                InkWell(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Color(0xFF011D5B),
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage(),
                      ),
                    )
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
