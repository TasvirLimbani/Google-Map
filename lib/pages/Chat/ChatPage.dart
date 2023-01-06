import 'package:demo/pages/Chat/Screen/HomePage.dart';
import 'package:demo/pages/Chat/Screen/LoginPage.dart';
import 'package:demo/pages/Chat/Services/auth.dart';
import 'package:demo/pages/Chat/models/User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LoginUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.blueGrey,
            fontFamily: GoogleFonts.kanit().fontFamily),
        home: LoginScreen(),
      ),
    );
  }
}
