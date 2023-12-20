import 'package:bookbuddies/pages/LoginPage.dart';
import 'package:bookbuddies/pages/MainPage.dart';
import 'package:bookbuddies/services/providers/User/User.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final UserProvider userProvider = UserProvider();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  Future<void> register() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String firstName = _firstnameController.text;
    String lastName = _lastnameController.text;
    String password = _passwordController.text;

    bool registrationSuccess = await userProvider.register(
      username,
      email,
      firstName,
      lastName,
      password,
    );

    if (registrationSuccess) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Register Sukses! Selamat datang, $username."),
          ),
        );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text("Register Gagal!"),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 70.0),
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
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
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
              SizedBox(height: 12.0),
              TextField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
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
              SizedBox(height: 12.0),
              TextField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
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
              SizedBox(height: 12.0),
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
              SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
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
              SizedBox(height: 12.0),
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  backgroundColor: Color(0xFF5B011B),
                ),
                onPressed: () => register(),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color(0xFF5B011B),
                      fontSize: 21,
                    ),
                  ),
                  SizedBox(width: 4),
                  InkWell(
                    child: Text(
                      "Log In",
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
                          builder: (context) => LoginPage(),
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
