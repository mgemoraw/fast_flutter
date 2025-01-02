import 'package:fast_app/models/user.dart';
import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  final User user;
  const MyForm({Key? key, required this.user}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  var idController = new TextEditingController();
  var nameController = new TextEditingController();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = this.widget.user.id.toString();
    idController.text = this.widget.user.name;
    idController.text = this.widget.user.email;
    idController.text = this.widget.user.password;
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
                  decoration: InputDecoration(hintText: "Enter ID"),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Email"),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "Enter Password"),
              ),
              SizedBox(height: 20),
              MaterialButton(
                color: Colors.blue,
                child: Text("Submit"),
                minWidth: double.infinity,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
