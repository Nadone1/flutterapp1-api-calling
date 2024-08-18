// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Rest API Call"),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];

            final email = user['email'];
            final name = user['name']['first'];
            final imageUrl = user['picture']['thumbnail'];
            return ListTile(
              leading: ClipRect(
                child: Image.network(imageUrl),
              ),
              subtitle: Text(email),
              title: Text(name),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async {
    const url = "https://randomuser.me/api/?results=10";
    final uri = Uri.parse(url);
    final response =
        await http.get(uri); // Add 'await' to wait for the response
    final body = response.body; // Now it's safe to access 'body'
    final json = jsonDecode(body);

    setState(() {
      users = json['results'];
    });

    print("results being fetched");
  }
}
