// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:stripe_payment/stripe_payment.dart';
//
// class StripeTranscationResponse {
//   String message;
//   bool success;
//   StripeTranscationResponse({required this.message, required this.success});
// }
//
// class StripeService {
//   static String apiBase = "https://api.stripe.com/v1";
//   static String paymentApiUri = "${StripeService.apiBase}/payment_intents";
//   static String secret =
//       "sk_test_51KOgXnSDVD9JkNVGWmHbH9MbaUvFlcTHeTPumA62jVfp0PWuTNS0SM9Hpk34s9QgoGzb3x1TB9Vm1LNPz5g6NcIS00yVoD4s64";
//
//   static Map<String, String> headers = {
//     'Authorization': 'Bearer ${StripeService.secret}',
//     'Content-type': 'application/x-www-form-urlencoded'
//   };
//   static init() {
//     StripePayment.setOptions(StripeOptions(
//         publishableKey:
//             "pk_test_51KOgXnSDVD9JkNVGZZT7tkzhGj1SwXVWg9CbEJm60MfZ8DTh5xHwikpskgHVTNDKoECY13DW3CSVCaqeFILvo2Ji00FccoGkQv",
//         merchantId: "Test",
//         androidPayMode: "Test"));
//   }
//
//   static Future<Map<String, dynamic>?> createPaymentIntent(
//       String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {"amount": amount, "currency": currency};
//       var response = await http.post(Uri.parse(StripeService.paymentApiUri),
//           headers: headers, body: body);
//       return jsonDecode(response.body);
//     } catch (e) {
//       print("****** $e ******");
//     }
//     return null;
//   }
//
//   static Future<StripeTranscationResponse?> payWithNewCard(
//       String amount, String currency) async {
//     try {
//       var paymentMethod = await StripePayment.paymentRequestWithCardForm(
//           CardFormPaymentRequest());
//       var paymentIntent =
//           await StripeService.createPaymentIntent(amount, currency);
//       var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
//           clientSecret: paymentIntent!['client_secret'],
//           paymentMethodId: paymentMethod.id));
//       if (response.status == "succeeded") {
//         return StripeTranscationResponse(
//             success: true, message: "Transaction success");
//       } else {
//         return StripeTranscationResponse(
//             success: false, message: "Transaction failed");
//       }
//     } catch (e) {
//       print("****** $e ******");
//     }
//     return null;
//   }
// }



