import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookbuddies/models/Loan/Loan.dart';

class ListLoanBookPage extends StatefulWidget {
  const ListLoanBookPage({Key? key}) : super(key: key);

  @override
  _ListLoanBookPageState createState() => _ListLoanBookPageState();
}

class _ListLoanBookPageState extends State<ListLoanBookPage> {
  Future<List<Loan>> fetchLoanBooks() async {
    var url = Uri.parse('http://localhost:8000/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Loan> listLoan = [];
    for (var d in data) {
      if (d != null) {
        listLoan.add(Loan.fromJson(d));
      }
    }
    return listLoan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Borrowed Books'),
      ),
      body: FutureBuilder(
        future: fetchLoanBooks(),
        builder: (context, AsyncSnapshot<List<Loan>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text(
                "No borrowed books yet.",
                style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${snapshot.data![index].fields.book}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text("Nama: ${snapshot.data![index].fields.name}"),
                    const SizedBox(height: 10),
                    Text("Due Date: ${snapshot.data![index].fields.dueDate}"),
                    const SizedBox(height: 10),
                    Text("Address: ${snapshot.data![index].fields.address}"),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
