
import 'package:firebase_database/firebase_database.dart';
import 'package:my_plans/model/post_model.dart';

class RTDBService {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<Event>> addPost(Post post) async {
   await _database.child('posts').push().set(post.toJson());
   return _database.onChildAdded;
  }


}