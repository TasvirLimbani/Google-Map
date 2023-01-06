import 'package:demo/Screens/FirstPage.dart';
import 'package:demo/pages/Notification/NotificationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51KPBpMD7PODSamJce9ipvXPg2p2CRe7MyDvwAjUSgxhbwMbjBr26omBWdLr2kA2g2RNdlaWosJLQYX9ncAE22GgW00E4qqTt5A";
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.blueGrey,
          fontFamily: GoogleFonts.kanit().fontFamily),
      home: FirstPage(),
    );
  }
}
