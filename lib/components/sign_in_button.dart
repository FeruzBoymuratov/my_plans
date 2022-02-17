import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_plans/pages/posts_page.dart';
import 'package:my_plans/services/auth_service.dart';
import 'package:my_plans/utils/constants.dart';
import 'package:my_plans/utils/resource.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SignInButton extends StatefulWidget {
  final FaIcon faIcon;
  final LoginType loginType;
  final textLabel;

  const SignInButton({Key? key, required this.faIcon, required this.loginType, this.textLabel})
      : super(key: key);

  @override
  _SignInButtonState createState() => _SignInButtonState();
}

class _SignInButtonState extends State<SignInButton> {
  bool isLoading = false;
  FirebaseService service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? SizedBox(
      width: size.width * 0.8,
      child: OutlinedButton.icon(
        icon: widget.faIcon,
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await loginWithProviders();
          setState(() {
            isLoading = false;
          });
        },
        label: Text(
          widget.textLabel,
          style: const TextStyle(
              color: Constants.kBlackColor, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Constants.kGreyColor),
            side: MaterialStateProperty.all<BorderSide>(BorderSide.none)),
      ),
    )
        : const CircularProgressIndicator();
  }

  void showMessage(FirebaseAuthException e) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(e.message!),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                  if (e.code == 'account-exists-with-different-credential') {
                    List<String> emailList = await FirebaseAuth.instance
                        .fetchSignInMethodsForEmail(e.email!);
                    if (emailList.first == "google.com" || emailList.first == "twitter.com") {
                      await service.signInwithGoogle(true, e.credential);
                      Navigator.pushNamedAndRemoveUntil(
                          context, Constants.verifyOtp, (route) => false);
                    }
                  }
                },
              )
            ],
          );
        });
  }

  Future<void> loginWithProviders() async {
    String? displayName;
    Resource? result = Resource(status: Status.Error);
    try {
      switch (this.widget.loginType) {
        case LoginType.Google:
          displayName = (await service.signInwithGoogle());
          break;
      }
      if (result.status == Status.Success || displayName != null) {
        Navigator.pushReplacementNamed(context, PostsPage.id);
      }
    } on Exception catch (e) {
      if (e is FirebaseAuthException) {
        showMessage(e);
      }
    }
  }
}