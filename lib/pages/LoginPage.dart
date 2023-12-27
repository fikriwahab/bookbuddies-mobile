// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors, use_build_context_synchronously

import 'package:bookbuddies/models/User/User.dart';
import 'package:bookbuddies/pages/ForgotPasswordPage.dart';
import 'package:bookbuddies/pages/MainPage.dart';
import 'package:bookbuddies/pages/RegisterPage.dart';
import 'package:bookbuddies/services/providers/User/User.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    final request = context.watch<CookieRequest>();
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
                            fontWeight: FontWeight.bold)),
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
                obscureText:
                    _isPasswordObscured, // Use a variable to toggle obscuring
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
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  backgroundColor: Color(0xFF5B011B),
                ),
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  final response =
                      await request.login("http://127.0.0.1:8000/auth/login/", {
                    'username': username,
                    'password': password,
                  });

                  if (request.loggedIn) {
                    String message = response['message'];
                    String uname = response['username'];
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content: Text("$message Selamat datang, $uname.")));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Login Gagal'),
                        content: Text(response['message']),
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
          )),
    );
  }
}
