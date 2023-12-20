import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookbuddies/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookbuddies/pages/DetailBookPage.dart';

class BorrowFormPage extends StatefulWidget {
  final int bookId;

  BorrowFormPage({required this.bookId});

  @override
  _BorrowFormPageState createState() => _BorrowFormPageState();
}

class _BorrowFormPageState extends State<BorrowFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _dueDate = '';
  String _address = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    Widget buildTextFormField({
      required String labelText,
      required String hintText,
      required Function(String) onChanged,
      required String? Function(String?)? validator,
      required TextInputType keyboardType,
      required Color textColor,
      required Color borderColor,
      required OutlineInputBorder border,
      required Color fillColor,
      required bool filled,
    }) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: borderColor),
            ),
            filled: filled, // Add this line
            fillColor: filled ? fillColor : null,
          ),
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Borrow Book Form',
          ),
        ),
        backgroundColor: Color.fromARGB(255, 26, 30, 224),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter your details to borrow the book:'),
              buildTextFormField(
                labelText: 'Name',
                hintText: 'Enter your name',
                textColor: const Color.fromARGB(255, 247, 245, 245),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: Color(0xFF011D5B),
                filled: true,
                borderColor: const Color.fromARGB(255, 28, 27, 27),
                onChanged: (String value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty!';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              buildTextFormField(
                labelText: 'Return Date',
                hintText: 'Enter the return date',
                textColor: const Color.fromARGB(255, 247, 245, 245),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: Color(0xFF011D5B),
                filled: true,
                borderColor: const Color.fromARGB(255, 28, 27, 27),
                onChanged: (String value) {
                  setState(() {
                    _dueDate = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Return Date cannot be empty!';
                  }
                  return null;
                },
                keyboardType: TextInputType.datetime,
              ),
              buildTextFormField(
                labelText: 'Address',
                hintText: 'Enter your address',
                textColor: const Color.fromARGB(255, 247, 245, 245),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: Color(0xFF011D5B),
                filled: true,
                borderColor: const Color.fromARGB(255, 28, 27, 27),
                onChanged: (String value) {
                  setState(() {
                    _address = value;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Address cannot be empty!';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 113, 45, 45)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                        final response = await request.postJson(
                          "http://localhost:8000/create-flutter/",
                          jsonEncode(<String, dynamic>{
                            'name': _name,
                            'dueDate': _dueDate,
                            'address': _address,
                            'bookId': widget.bookId,
                            // TODO: Sesuaikan field data sesuai dengan aplikasimu
                          }),
                        );

                        // Memeriksa respons dari server
                        if (response['status'] == 'success') {
                          // Jika sukses, tampilkan snackbar dan navigasikan ke halaman utama

                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("Borrow request submitted successfully!"),
                          ));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailPage(
                                bookId: widget.bookId,
                              ),
                            ),
                          );
                        } else {
                          // Jika ada kesalahan, tampilkan snackbar dengan pesan kesalahan
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("There was an error, please try again."),
                          ));
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style:
                          TextStyle(color: Color.fromARGB(255, 250, 248, 248)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
