import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/post.dart';
import 'dart:async';

// A service to assist in getting, updating, and creating posts
// All data is handled by firebase
class PostService {
  final Duration timeout = const Duration(seconds: 30);

  // add a new post to firebase
  static Future<Post> addPost(Post post) async {
    Map map = post.toMap();
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      post.reference = await Firestore.instance.collection('post').add(map);
    });

    return Post.fromSnapshot(await post.reference.get());
  }

  // get a post from firebase
  static Future<Post> getPost(Post post) async {
    DocumentSnapshot snapshot = await post.reference.get();
    return Post.fromSnapshot(snapshot);
  }
  
  // get posts by specific user
  static Future<List<Post>> getPostsByUserId(String id) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('post').where("userId", isEqualTo: id).getDocuments();
    List<DocumentSnapshot> documents = snapshot.documents;
    List<Post> posts = documents.map((documentSnapshot) => Post.fromSnapshot(documentSnapshot)).toList();
    return posts;
  }

  // update a post in firebase
  static Future<Post> updatePost(Post post) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      await post.reference.updateData(post.toMap());
    });
    
    return post;
  }

  // get posts from firebase
  static Future<List<Post>> getPosts(String id) async {
    List<Post> posts;

    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('post')
        .where("userId", isEqualTo: id)
        .getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;
      posts = documents.map((documentSnapshot) => Post.fromSnapshot(documentSnapshot)).toList();
    });

    return posts;
  }
}