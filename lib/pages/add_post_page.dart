import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_plans/pages/posts_page.dart';
import 'package:my_plans/services/rtdb_service.dart';
import 'package:my_plans/services/store_service.dart';

import '../model/post_model.dart';
import '../services/prefs_service.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  static const String id = "addPost_page";

  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {

  var isLoading = false;
  File? _image;
  final picker = ImagePicker();

  var fullnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  _addPost() async {
    String fullname = fullnameController.text.toString();
    String lastname = fullnameController.text.toString();
    String content = fullnameController.text.toString();
    String date = fullnameController.text.toString();
    if (fullname.isEmpty || lastname.isEmpty || content.isEmpty || date.isEmpty) return;
    if (_image == null) return;

    _apiUploadImage(fullname, lastname, content, date);
  }

  void _apiUploadImage(String fullname, String lastname, String content, String date) {
    setState(() {
      isLoading = true;
    });
    StoreService.uploadImage(_image!).then((imgUrl) => {
      _apiAddPost(fullname, lastname, content, date, imgUrl!),
    });
  }

  _apiAddPost(String fullname, String lastname, String content, String date, String imgUrl) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(Post(id!, fullname, lastname, content, date, imgUrl)).then((response) => {
      _respAddPost(),
    });
  }

  _respAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({"data": "done"});
  }

  Future _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }else{
        print("Rasm tanlanmadi!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.1,
        shadowColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.clear_rounded, size: 35, color: Colors.white54,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, PostsPage.id);
          },
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
      SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              GestureDetector(
                onTap: _getImage,
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: _image != null ?
                  Image.file(_image!,fit: BoxFit.cover) :
                  Image.asset("assets/images/ic_camera.png"),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: fullnameController,
                decoration: const InputDecoration(
                  hintText: "Fullname",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: lastnameController,
                decoration: const InputDecoration(
                  hintText: "Lastname",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: "Content",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  hintText: "Date",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: FlatButton(
                  onPressed: _addPost,
                  color: Colors.amber,
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

          isLoading? const Center(
            child: CircularProgressIndicator(),
          ): const SizedBox.shrink(),
        ],
      ),
    );
  }
}
