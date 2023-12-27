import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BorrowFormPage extends StatefulWidget {
  final int bookId;

  BorrowFormPage({required this.bookId});

  @override
  _BorrowFormPageState createState() => _BorrowFormPageState();
}

class _BorrowFormPageState extends State<BorrowFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _returnDate = '';
  String _address = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    Widget buildTextFormField({
      required String labelText,
      required String hintText,
      required Function(String) onChanged,
      required String Function(String?)? validator,
      required TextInputType keyboardType,
    }) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Borrow Book Form'),
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
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return "";
                },
                keyboardType: TextInputType.text,
              ),
              buildTextFormField(
                labelText: 'Return Date',
                hintText: 'Enter the return date',
                onChanged: (value) {
                  setState(() {
                    _returnDate = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Return Date cannot be empty';
                  }
                  return "null";
                },
                keyboardType: TextInputType.datetime,
              ),
              buildTextFormField(
                labelText: 'Address',
                hintText: 'Enter your address',
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address cannot be empty';
                  }
                  return "null";
                },
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final response = await request.postJson(
                      "http://localhost:8000/create-borrower/",
                      jsonEncode(<String, dynamic>{
                        'name': _name,
                        'return_date': _returnDate,
                        'address': _address,
                      }),
                    );

                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Borrow request submitted successfully!"),
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("There was an error, please try again."),
                      ));
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
