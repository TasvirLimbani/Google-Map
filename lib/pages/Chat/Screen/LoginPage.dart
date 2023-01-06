import 'package:demo/pages/Chat/Colors/Colors.dart';
import 'package:demo/pages/Chat/Screen/HomePage.dart';
import 'package:demo/pages/Chat/Screen/OtpPage.dart';
import 'package:demo/pages/Chat/Screen/RegisterPage.dart';
import 'package:demo/pages/Chat/Services/auth.dart';
import 'package:demo/pages/Chat/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _phonenumnberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String phonenumber = "";
  String email = "";
  String password = "";
  String verificationID = "";
  bool _isLoading = false;
  bool termsValue = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                        child: const Text('Hello',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 175.0, 0.0, 0.0),
                        child: const Text('There',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(220.0, 175.0, 0.0, 0.0),
                        child: Text('.',
                            style: TextStyle(
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold,
                                color: lightColor)),
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 350,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
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
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              validator: (val) {
                                if (val!.isEmpty || val.length < 6) {
                                  return "Enter Valid Password";
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
                            const SizedBox(
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
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (_formkey.currentState!.validate()) {
                                  if (termsValue) {
                                    _formkey.currentState!.save();
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      LoginUser? user = await AuthService()
                                          .signInwithEmailandPassword(
                                              email: email, password: password);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()),
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
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                        },
                        child: Text(
                          "sign up",
                          style: TextStyle(color: darkColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
// 6342bb
// 8a6bdd

//
// Form(
// key: _formkey,
// child: Container(
// alignment: Alignment.center,
// margin: EdgeInsets.symmetric(horizontal: 40),
// child: TextFormField(
// controller: _phonenumnberController,
// onSaved: (val) {
// setState(() {
// phonenumber = val!;
// });
// },
// validator: (val) {
// if (val!.isEmpty || val == " " || val == "  ") {
// return "Enter Phone Number";
// }
// },
// decoration: InputDecoration(labelText: "Phone Number"),
// ),
// ),
// ),
