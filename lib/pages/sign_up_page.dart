// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// import '../services/auth_service.dart';
// import '../utils/constants.dart';
//
// class SignUpPage extends StatefulWidget {
//   static const String id = "sign_in";
//   const SignUpPage({Key? key}) : super(key: key);
//
//   @override
//   _SignInPageState createState() => _SignInPageState();
// }
//
// class _SignInPageState extends State<SignUpPage> {
//
//   @override
//   void initState() {
//     super.initState();
//     Firebase.initializeApp().whenComplete(() {
//       print("completed");
//       setState(() {});
//     });
//   }
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otpCode = TextEditingController();
//
//   OutlineInputBorder border = const OutlineInputBorder(
//       borderSide: BorderSide(color: Constants.kBorderColor, width: 3.0));
//
//   bool isLoading = false;
//
//   String? verificationId;
//
//   Future<void> phoneSignIn({required String phoneNumber}) async {
//     await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: _onVerificationCompleted,
//         verificationFailed: _onVerificationFailed,
//         codeSent: _onCodeSent,
//         codeAutoRetrievalTimeout: _onCodeTimeout);
//   }
//
//   _onVerificationCompleted(PhoneAuthCredential authCredential) async {
//     if (kDebugMode) {
//       print("verification completed ${authCredential.smsCode}");
//     }
//     User? user = FirebaseAuth.instance.currentUser;
//     setState(() {
//       otpCode.text = authCredential.smsCode!;
//     });
//     if (authCredential.smsCode != null) {
//       try{
//         UserCredential credential =
//         await user!.linkWithCredential(authCredential);
//       }on FirebaseAuthException catch(e){
//         if(e.code == 'provider-already-linked'){
//           await _auth.signInWithCredential(authCredential);
//         }
//       }
//       setState(() {
//         isLoading = false;
//       });
//       Navigator.pushNamedAndRemoveUntil(
//           context, Constants.homeNavigate, (route) => false);
//     }
//   }
//
//   _onVerificationFailed(FirebaseAuthException exception) {
//     if (exception.code == 'invalid-phone-number') {
//       showMessage("The phone number entered is invalid!");
//     }
//   }
//
//   _onCodeSent(String verificationId, int? forceResendingToken) {
//     this.verificationId = verificationId;
//     if (kDebugMode) {
//       print(forceResendingToken);
//     }
//     if (kDebugMode) {
//       print("code sent");
//     }
//   }
//
//   _onCodeTimeout(String timeout) {
//     return null;
//   }
//
//   void showMessage(String errorMessage) {
//     showDialog(
//         context: context,
//         builder: (BuildContext builderContext) {
//           return AlertDialog(
//             title: const Text("Error"),
//             content: Text(errorMessage),
//             actions: [
//               TextButton(
//                 child: const Text("Ok"),
//                 onPressed: () async {
//                   Navigator.of(builderContext).pop();
//                 },
//               )
//             ],
//           );
//         }).then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery
//         .of(context)
//         .size;
//     return Scaffold(
//         appBar: AppBar(title: const Text("Verify OTP"),
//           systemOverlayStyle: const SystemUiOverlayStyle(
//               statusBarColor: Colors.blue),),
//         body: Center(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: size.width * 0.8,
//                   child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       controller: phoneNumber,
//                       decoration: InputDecoration(
//                         labelText: "Enter Phone",
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 15.0, horizontal: 10.0),
//                         border: border,
//                       )),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.01,
//                 ),
//                 SizedBox(
//                   width: size.width * 0.8,
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     controller: otpCode,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Enter Otp",
//                       contentPadding: const EdgeInsets.symmetric(
//                           vertical: 15.0, horizontal: 10.0),
//                       border: border,
//                       suffixIcon: const Padding(
//                         child: Icon(
//                           Icons.panorama_fish_eye,
//                           size: 15,
//                         ),
//                         padding: EdgeInsets.only(top: 15, left: 15),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
//                 !isLoading
//                     ? SizedBox(
//                   width: size.width * 0.8,
//                   child: OutlinedButton(
//                     onPressed: () async {
//                       FirebaseService service = FirebaseService();
//                       if (_formKey.currentState!.validate()) {
//                         setState(() {
//                           isLoading = true;
//                         });
//                         await phoneSignIn(phoneNumber: phoneNumber.text);
//                       }
//                     },
//                     child: const Text(Constants.textSignIn),
//                     style: ButtonStyle(
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                             Constants.kPrimaryColor),
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                             Constants.kBlackColor),
//                         side: MaterialStateProperty.all<BorderSide>(
//                             BorderSide.none)),
//                   ),
//                 )
//                     : const CircularProgressIndicator(),
//               ],
//             ),
//           ),
//         ));
//     }
//   }