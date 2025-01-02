import 'dart:convert';

import 'package:fast_app/models/user.dart';
import 'package:fast_app/screens/form.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:fast_app/screens/home.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

Future fetch_users() async {
  var response = await http.get(Uri.parse('http://127.0.0.1:8000'));
  var users = [];
  for (var u in jsonDecode(response.body)) {
    users.add(User(u['id'], u['name'], u['email'], u['password']));
  }
  print(users);
  return users;
}

class _MyListState extends State<MyList> {
  @override
  void initState() {
    super.initState();
    fetch_users();
  }

  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: fetch_users(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => Home(
                              widgetName: MyForm(
                                user: snapshot.data[index],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
            }
          }),
    );
  }
}