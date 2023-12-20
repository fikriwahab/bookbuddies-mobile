import 'package:bookbuddies/pages/RegisterPage.dart';
import 'package:bookbuddies/services/providers/User/User.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final UserProvider userProvider = UserProvider();
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
                  // Note: Styles for TextSpans must be explicitly defined.
                  // Child text spans will inherit styles from parent
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
              Icon(
                Icons.lock,
                size: 100,
                color: Color(0xFF011D5B),
              ),
              SizedBox(height: 10.0),
              Text(
                "Enter your email, phone or username and we'll send you a link to reset your password",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Phone number, Username, Email',
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
              FilledButton(
                style: FilledButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  backgroundColor: Color(0xFF5B011B),
                ),
                onPressed: () async {
                  bool loginSuccess = await userProvider.login(
                    _usernameController.text,
                    _passwordController.text,
                  );

                  debugPrint(loginSuccess.toString());

                  if (loginSuccess) {
                    debugPrint('Login Successful');

                    String? token = await userProvider.getAccessToken();
                    debugPrint('Access Token: $token');
                  } else {
                    debugPrint('Login Failed');
                  }
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(fontSize: 20),
                ),
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
