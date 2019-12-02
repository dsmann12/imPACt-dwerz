import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/post.dart';
import 'dart:async';

class PostService {
  final Duration timeout = const Duration(seconds: 30);

  static Future<Post> addPost(Post post) async {
    Map map = post.toMap();
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      post.reference = await Firestore.instance.collection('post').add(map);
    });

    return Post.fromSnapshot(await post.reference.get());
  }

  static Future<Post> getPost(Post post) async {
    DocumentSnapshot snapshot = await post.reference.get();
    return Post.fromSnapshot(snapshot);
  }

  static Future<List<Post>> getPostsByUserId(String id) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('post').where("userId", isEqualTo: id).getDocuments();
    List<DocumentSnapshot> documents = snapshot.documents;
    List<Post> posts = documents.map((documentSnapshot) => Post.fromSnapshot(documentSnapshot)).toList();
    return posts;
  }

  static Future<Post> updatePost(Post post) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      await post.reference.updateData(post.toMap());
    });
    
    return post;
  }

  static Future<List<Post>> getPosts(List<String> ids) async {
    List<Post> users;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('post').where("userId", arrayContains: ids).getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      users = documents.map((documentSnapshot) => Post.fromSnapshot(documentSnapshot)).toList();
    });

    return users;
  }
}