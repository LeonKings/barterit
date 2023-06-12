import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../myconfig.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Registration Form"),
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).colorScheme.secondary,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                color: const Color.fromRGBO(64, 147, 247, 50),
                child: Image.asset(
                  'assets/images/register.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Card(
                elevation: 8,
                child: Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameEditingController,
                                  validator: (val) =>
                                      val!.isEmpty || (val.length < 3)
                                          ? "name must be longer than 3"
                                          : null,
                                  decoration: const InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(),
                                      icon: Icon(Icons.person),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0))),
                                ),
                                TextFormField(
                                  controller: _emailditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) => val!.isEmpty ||
                                          (!val.contains("@")) ||
                                          (!val.contains("."))
                                      ? "enter a valid email"
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(),
                                      icon: Icon(Icons.mail),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0))),
                                ),
                                TextFormField(
                                  controller: _passEditingController,
                                  validator: (val) =>
                                      val!.isEmpty || (val.length < 7)
                                          ? "password must be longer than 7"
                                          : null,
                                  obscureText: _passwordVisible1,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible1
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible1 =
                                                !_passwordVisible1;
                                          });
                                        },
                                      ),
                                      labelText: 'Password',
                                      labelStyle: const TextStyle(),
                                      icon: const Icon(Icons.lock),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0))),
                                ),
                                TextFormField(
                                  controller: _pass2EditingController,
                                  //checking if the password same of not
                                  validator: (val) =>
                                      val!.isEmpty || (val.length < 7)
                                          ? "password must be longer than 7"
                                          : null,
                                  obscureText: _passwordVisible2,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _passwordVisible2
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible2 =
                                                !_passwordVisible2;
                                          });
                                        },
                                      ),
                                      labelText: 'Reenter Password',
                                      labelStyle: const TextStyle(),
                                      icon: const Icon(Icons.lock),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0))),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _isChecked = value!;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: null,
                                      child: const Text('Terms and Condition',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                        child: ElevatedButton(
                                            onPressed: regisDialog,
                                            child: const Text("Register")))
                                  ],
                                )
                              ],
                            ))
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  void regisDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Unsuccess Register, Please Recheck your input")));
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Check the terms and Condition")));
      return;
    }
    String pass1 = _passEditingController.text;
    String pass2 = _pass2EditingController.text;
    if (pass1 != pass2) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your password")));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                regisUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void regisUser() {
    String name = _nameEditingController.text;
    String email = _emailditingController.text;
    String password = _passEditingController.text;

    http.post(Uri.parse("${MyConfig().SERVER}/barterit/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "password": password
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Success")));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Registration Failed")));
      }
    });
  }
}
