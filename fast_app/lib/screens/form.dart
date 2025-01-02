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

Future add_users(user) async {
  // final url = Uri.parse('http://10.161.70.104:8000');
  final url = Uri.parse("http://localhost:8000");
  final headers = {"Content-Type": "application/json"};
  final body = jsonEncode(<String, String>{
    'name': user.name,
    'email': user.email,
    'password': user.password,
  });
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
  } catch (err) {
    // await http.put(Uri.parse('http://10.161.70.104:8000/' + user.id.toString()),
    //     headers: <String, String>{
    //       "Content-Type": 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String, String>{
    //       'name': user.name,
    //       'email': user.email,
    //       'password': user.password,
    //     }));
    print("user data: $user");
    print(err.toString());
  }

  return user;
}

class _MyFormState extends State<MyForm> {
  TextEditingController idController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      idController.text = this.widget.user.id.toString();
      idController.text = this.widget.user.name;
      idController.text = this.widget.user.email;
      idController.text = this.widget.user.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: [
              Visibility(
                visible: false,
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
              ),
              SizedBox(height: 20),
              MaterialButton(
                color: Colors.blue,
                child: Text("Submit"),
                minWidth: double.infinity,
                onPressed: () {
                  setState(() {
                    add_users(User(1, nameController.text, emailController.text,
                        passwordController.text));

                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Home(
                          widgetName: MyList(),
                          title: "List",
                          index: 0,
                        ),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
