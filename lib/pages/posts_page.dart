import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:my_plans/pages/add_post_page.dart';
import 'package:my_plans/services/rtdb_service.dart';

import '../model/post_model.dart';
import '../services/prefs_service.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  static const String id = "posts_page";

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  late final User user;
  List<Post> items = [];
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    _apiGetPosts();
  }

  Future _openAddPost() async{
    Map results = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext){
      return AddPostPage();
    }));
    if (results != null && results.containsKey("data")) {
      print(results["data"]);
      _apiGetPosts();
    }
  }

  _apiGetPosts() async{
    setState(() {
      isLoading = true;
    });
    var id = await Prefs.loadUserId();
    RTDBService.getPosts(id!).then((posts) => {
      _respPosts(posts),
    });
  }

  _respPosts(List<Post> posts) {
    setState(() {
      isLoading = false;
      items = posts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("REJALAR:", style: TextStyle(color: Colors.white),),
        elevation: 0.1,
        shadowColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: (){
              // AuthService.signOutUser(context);
            },
            icon: Icon(Icons.exit_to_app,color: Colors.white,),
          ),
        ],
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
                  margin: const EdgeInsets.only(left: 30, right: 30, top: 140),
                  width: double.infinity,
                  borderRadius: 20,
                  blur: 5,
                  alignment: Alignment.bottomCenter,
                  border: 2,
                  linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFffffff).withOpacity(0.1),
                        const Color(0xFFFFFFFF).withOpacity(0.05),
                      ],
                      stops: const [
                        0.1,
                        1,
                      ]),
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFffffff).withOpacity(0.5),
                      const Color((0xFFFFFFFF)).withOpacity(0.5),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height,
                   child: ListView.builder(
                     itemCount: items.length,
                        itemBuilder: (ctx, i){
                       return itemOfList(items[i]);
                        },
                   ),
                ),
              ),
              isLoading?
                  const Center(
                    child: CircularProgressIndicator(),
                  ): const SizedBox.shrink(),

              GlassmorphicContainer(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 10),
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
                      const Color(0xFFffffff).withOpacity(0.1),
                      const Color(0xFFFFFFFF).withOpacity(0.05),
                    ],
                    stops: const [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFFffffff).withOpacity(0.5),
                    const Color((0xFFFFFFFF)).withOpacity(0.5),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, AddPostPage.id);
                            },
                          child: Text("Add", style: TextStyle(color: const Color(0xFFffffff).withOpacity(0.6), fontWeight: FontWeight.bold, fontSize: 20),),
                      ),
                    ),
                    VerticalDivider(
                      endIndent: 5,
                      indent: 5,
                      width: 1,
                      thickness: 2,
                      color: const Color(0xFFffffff).withOpacity(0.3),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){

                        },
                        child: Text("Edit", style: TextStyle(color: const Color(0xFFffffff).withOpacity(0.6), fontSize: 19),),
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
   Widget itemOfList(Post post){
     return Container(
       padding: EdgeInsets.all(20),
       child: Stack(
         children: [
           Container(
             height: 50,
             width: double.infinity,
             child: post.img_url != null ?
             Image.network(post.img_url, fit: BoxFit.cover,):
             Image.asset("assets/images/ic_camera.png"),
           ),
           Row(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("${post.fullname} ${post.lastname}", style: TextStyle(color: Colors.white, fontSize: 20),),
               SizedBox(height: 10,),
               Text("${post.content} ${post.date}", style: TextStyle(color: Colors.white, fontSize: 16),),
             ],
           ),
         ],
       ),
     );
  }
}
