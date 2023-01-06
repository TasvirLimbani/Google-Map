import 'package:demo/pages/Chat/Colors/Colors.dart';
import 'package:demo/pages/Chat/Screen/LoginPage.dart';
import 'package:demo/pages/Chat/Services/auth.dart';
import 'package:demo/pages/Chat/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String email = "";
  String password = "";
  bool termsValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, top: 40),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey.shade300),
                child: Icon(Icons.arrow_back),
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 0.0, 0.0),
                  child: const Text('Hello',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 70.0, 0.0, 0.0),
                  child: const Text('There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(220.0, 70.0, 0.0, 0.0),
                  child: Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.bold,
                          color: lightColor)),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade200),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter Valid Email";
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                email = val!;
                              });
                            },
                            style: TextStyle(
                              color: lightColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Email Address",
                              labelText: "Email Address",
                              labelStyle:
                                  TextStyle(color: lightColor, height: 0.7),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              border: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [darkColor, lightColor])),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty || val.length < 6) {
                                return "Enter Password";
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                password = val!;
                              });
                            },
                            obscureText: true,
                            style: TextStyle(
                              color: lightColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "Password",
                              labelText: "Password",
                              labelStyle:
                                  TextStyle(color: lightColor, height: 0.7),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              border: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [darkColor, lightColor])),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty || val.length < 6) {
                                return "Enter Password";
                              }
                            },
                            onSaved: (val) {
                              setState(() {});
                            },
                            obscureText: true,
                            style: TextStyle(
                              color: lightColor,
                            ),
                            decoration: InputDecoration(
                              hintText: "confirm Password",
                              labelText: "confirm Password",
                              labelStyle:
                                  TextStyle(color: lightColor, height: 0.7),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              disabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              border: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 2,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [darkColor, lightColor])),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CheckboxListTile(
                              activeColor: darkColor,
                              dense: true,
                              title: Text(
                                "Accept terms & conditions*",
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              value: termsValue,
                              onChanged: (val) {
                                setState(() {
                                  termsValue = val!;
                                });
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formkey.currentState!.validate()) {
                                if (termsValue) {
                                  _formkey.currentState!.save();
                                  try {
                                    LoginUser? user = await AuthService()
                                        .registerwithEmailandPassword(
                                            email: email, password: password);

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (route) => false);
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                  }
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [darkColor, lightColor],
                                ),
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -70,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
