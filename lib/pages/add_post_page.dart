import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  static const String id = "addPost_page";

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.1,
        shadowColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.clear_rounded, size: 35, color: Colors.white54,),
          onPressed: () {  },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Neumorphic(
            child: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 100,
                      height: 100,
                      child: _image != null ?
                      Image.file(_image, fit: BoxFit.cover,) :
                      Image.asset("assets/images/ic_camera.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
