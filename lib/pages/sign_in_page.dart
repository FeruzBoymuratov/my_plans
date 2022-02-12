import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:glassmorphism/glassmorphism.dart';

class SignInPage extends StatefulWidget {
  static const String id = "sign_in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.amber,
              gradient: LinearGradient(
                  colors: [
                Colors.amber.shade100,
                Colors.amber.shade200,
                Colors.amber.shade300,
                Colors.amber.shade400,
                Colors.amber.shade500,
                Colors.amber.shade600,
                Colors.amber.shade700,
                Colors.amber.shade800,
                Colors.amber.shade900,
              ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicText("SHAXSINGIZNI TASDIQLANG", textAlign: TextAlign.left, textStyle: NeumorphicTextStyle(fontSize: 30, ), style: NeumorphicStyle(color: Colors.amber.shade600),),
                const SizedBox(height: 20,),
                Neumorphic(
                  style: NeumorphicStyle(
                    color: Colors.amber.shade300,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    scrollPadding: const EdgeInsets.only(left: 10),
                    decoration: InputDecoration(
                      labelText: "Ismingiz:",
                      labelStyle: TextStyle(color: Colors.amber.shade700),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Neumorphic(
                  style: NeumorphicStyle(
                    color: Colors.amber.shade300,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "+998######## ko'rinishida",
                        hintStyle: TextStyle(color: Colors.amber.shade600),
                        labelText: "Telefon raqamingizni kiriting:",
                        labelStyle: TextStyle(color: Colors.amber.shade700),
                        border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                NeumorphicText("yoki",
                  textAlign: TextAlign.right,
                  textStyle: NeumorphicTextStyle(fontSize: 30, ),
                  style: NeumorphicStyle(color: Colors.amber.shade400),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){

                  },
                  child: GlassmorphicContainer(
                    alignment: Alignment.center,
                    height: 35,
                    width: 70,
                    shape: BoxShape.circle,
                    borderRadius: 10,
                    border: 5,
                    borderGradient: LinearGradient(
                      begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.amber.shade400,
                          Colors.amber.shade500,
                          Colors.amber.shade600,
                          Colors.amber.shade700,
                        ]
                    ), linearGradient: LinearGradient(
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.1),
                        const Color(0xFFFFFFFF).withOpacity(0.05),
                      ]),
                    blur: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('G', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        Text('o', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                        Text('o', style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),),
                        Text('g', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                        Text('l', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                        Text('e', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
