// import 'package:demo/pages/Chat/Screen/HomePage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class OtpScreen extends StatefulWidget {
//   String verificationId;
//   OtpScreen({Key? key, required this.verificationId}) : super(key: key);
//
//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }
//
// class _OtpScreenState extends State<OtpScreen> {
//   TextEditingController _OtpScreenController = TextEditingController();
//   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   String OtpScreen = "";
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   void signInwithPhoneAuthCredential(
//       PhoneAuthCredential phoneAuthCredential) async {
//     try {
//       final authCredential =
//           await _auth.signInWithCredential(phoneAuthCredential);
//       if (authCredential.user != null) {
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => HomePage()));
//       }
//     } on FirebaseException catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("${e.message}")));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Color(0xfff7f6fb),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Icon(
//                     Icons.arrow_back,
//                     size: 32,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//               Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                   color: Colors.deepPurple.shade50,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Image.network(
//                   'https://play-lh.googleusercontent.com/MjrPI6DZ82LTP0Gt6MtJrAruaAUIa4mj029OJDOpwiyNC4HLcqljzDVohqjDWEhoNl0',
//                 ),
//               ),
//               SizedBox(
//                 height: 24,
//               ),
//               Text(
//                 'Verification',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Text(
//                 "Enter your OtpScreen code number",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 28,
//               ),
//               Container(
//                 padding: EdgeInsets.all(28),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Form(
//                   key: _formkey,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           _textFieldOtpScreen(first: true, last: false),
//                           _textFieldOtpScreen(first: false, last: false),
//                           _textFieldOtpScreen(first: false, last: false),
//                           _textFieldOtpScreen(first: false, last: false),
//                           _textFieldOtpScreen(first: false, last: false),
//                           _textFieldOtpScreen(first: false, last: true),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 22,
//                       ),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formkey.currentState!.validate()) {
//                               _formkey.currentState!.save();
//                               setState(() {
//                                 PhoneAuthCredential phoneAuthCredential =
//                                     PhoneAuthProvider.credential(
//                                         verificationId: widget.verificationId,
//                                         smsCode: _OtpScreenController.text);
//                                 signInwithPhoneAuthCredential(
//                                     phoneAuthCredential);
//                               });
//                             }
//                           },
//                           style: ButtonStyle(
//                             foregroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                             // backgroundColor:
//                             //     MaterialStateProperty.all<Color>(Colors.purple),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(24.0),
//                               ),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: EdgeInsets.all(14.0),
//                             child: Text(
//                               'Verify',
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//               Text(
//                 "Didn't you receive any code?",
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: 18,
//               ),
//               Text(
//                 "Resend New Code",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   // color: Colors.purple,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _textFieldOtpScreen({required bool first, last}) {
//     return Container(
//       height: 50,
//       width: 40,
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: TextFormField(
//           // controller: _OtpScreenController,
//           autofocus: true,
//           onSaved: (val) {
//             setState(() {
//               OtpScreen = val!;
//               print("OtpScreen" + _OtpScreenController.text);
//             });
//           },
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context).nextFocus();
//             }
//             if (value.length == 0 && first == false) {
//               FocusScope.of(context).previousFocus();
//             }
//           },
//           showCursor: false,
//           readOnly: false,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//             counter: Offstage(),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 2, color: Colors.black12),
//                 borderRadius: BorderRadius.circular(12)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   width: 2,
//                   color: Color(0xFF2661FA),
//                 ),
//                 borderRadius: BorderRadius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
// }
