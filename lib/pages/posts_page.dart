import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  static const String id = "posts_page";

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("REJALAR:", style: TextStyle(color: Colors.white),),
        elevation: 0.1,
        shadowColor: Colors.amber,
        centerTitle: true,
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
          Column(
            children: [
              Expanded(
                child: GlassmorphicContainer(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 140),
                  width: double.infinity,
                  borderRadius: 20,
                  blur: 5,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.1),
                        Color(0xFFFFFFFF).withOpacity(0.05),
                      ],
                      stops: [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.5),
                      Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height,
                  // child: ListView.builder(
                  //      itemBuilder: //_item(),
                  // ),
                ),
              ),
              GlassmorphicContainer(
                margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 10),
                width: double.infinity,
                height: 50,
                borderRadius: 20,
                blur: 5,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFffffff).withOpacity(0.1),
                      Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFffffff).withOpacity(0.5),
                    Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){

                            },
                          child: Text("Add", style: TextStyle(color: Color(0xFFffffff).withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                    ),
                    VerticalDivider(
                      endIndent: 5,
                      indent: 5,
                      width: 1,
                      thickness: 2,
                      color: Color(0xFFffffff).withOpacity(0.3),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){

                        },
                        child: Text("Edit", style: TextStyle(color: Color(0xFFffffff).withOpacity(0.6), fontSize: 19),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // Widget _item(Post post){
  //   return Container(
  //     child: Stack(),
  //   );
  //}
}
