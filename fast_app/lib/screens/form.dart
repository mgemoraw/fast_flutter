import 'dart:convert';
import 'package:fast_app/models/user.dart';
import 'package:fast_app/screens/home.dart';
import 'package:fast_app/screens/list.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class MyForm extends StatefulWidget {
  final User user;
  const MyForm({Key? key, required this.user}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

Future<void> addUsers(User user) async {
  final url = Uri.parse('http://localhost:8000/users/create');
  final urlUpdate = Uri.parse('http://localhost:8000/users/update/${user.id}');
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode({
    'id': user.id,
    'name': user.name,
    'email': user.email,
    'password': user.password,
  });
  if (user.id == 0) {
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Failed to add user: $e");
    }
  } else {
    try {
      final response = await http.put(
        urlUpdate,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Failed to add user: $e");
    }
  }
}

class _MyFormState extends State<MyForm> {
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController(text: widget.user.id.toString());
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    passwordController = TextEditingController(text: widget.user.password);
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> handleSubmit() async {
    int? userId = int.tryParse(idController.text);

    if (userId == null) {
      showSnackBar("Invalid ID");
      return;
    }

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showSnackBar("All fields are required");
      return;
    }

    await addUsers(User(
      userId,
      nameController.text,
      emailController.text,
      passwordController.text,
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          widgetName: MyList(),
          title: "List",
          index: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        child: Column(
          children: [
            Visibility(
              visible: true,
              child: TextFormField(
                controller: idController,
                decoration: InputDecoration(hintText: "Enter ID"),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Enter Name"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: "Enter Email"),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(hintText: "Enter Password"),
              obscureText: true, // For security
            ),
            SizedBox(height: 20),
            MaterialButton(
              color: Colors.blue,
              child: Text("Submit", style: TextStyle(color: Colors.white)),
              minWidth: double.infinity,
              onPressed: handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
