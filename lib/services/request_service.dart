import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/user.dart';
import 'package:impact/services/user_service.dart';
import 'package:impact/models/request.dart';
import 'package:impact/models/post.dart';
import 'package:impact/services/post_service.dart';
import 'dart:async';

// A service to assist in getting, updating, and creating mentor requests between users
// All data is handled by firebase
class RequestService {
  final Duration timeout = const Duration(seconds: 30);

  // submit a new mentor request based on a request object
  static Future<Request> submitRequest(Request request) async {
    Map map = request.toMap();
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      request.reference = await Firestore.instance.collection('request').add(map);
    });

    return Request.fromSnapshot(await request.reference.get());
  }

  // accept a mentor request
  static Future<Request> acceptRequest(Request request) async {
    request.status = 1;
    request = await updateRequest(request);
    User mentor = await UserService.getUser(request.mentor.id);
    mentor.mentees.add(request.mentee.id);
    User mentee = await UserService.getUser(request.mentee.id);
    mentee.mentors.add(request.mentor.id);
    mentor = await UserService.updateUser(mentor);
    mentee = await UserService.updateUser(mentee);

    List<Post> posts = await PostService.getPostsByUserId(request.mentor.id);
    
    for (int i = 0; i < posts.length; ++i) {
      Post post = posts[i];
      post.mentees = mentor.mentees;
      PostService.updatePost(post);
    }
    return request;
  }

  // deny a mentor request
  static Future<Request> denyRequest(Request request) async {
    request.status = 2;
    request = await updateRequest(request);
    return request;
  }

  // delete a mentor request
  static Future<void> removeRequest(Request request) async {
    await Firestore.instance.runTransaction((Transaction tx,  {timeout}) async {
      await request.reference.delete();
    });    
  }

  // update a mentor request
  static Future<Request> updateRequest(Request request) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      await request.reference.updateData(request.toMap());
    });
    
    return request;
  }

  // get mentor requests sent to a user
  static Future<List<Request>> getRequestsByUser(String id) async {
    List<Request> requests;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('request')
        .where("mentor.id", isEqualTo: id)
        .where("status", isEqualTo: 0)
        .getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      requests = documents.map((documentSnapshot) => Request.fromSnapshot(documentSnapshot)).toList();
    });

    return requests;
  }

  // get mentor requests sent by a user
  static Future<List<Request>> getSentRequestsByUser(String id) async {
    List<Request> requests;
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      QuerySnapshot snapshot = await Firestore.instance.collection('request')
        .where("mentee.id", isEqualTo: id)
        .getDocuments();
      List<DocumentSnapshot> documents = snapshot.documents;

      requests = documents.map((documentSnapshot) => Request.fromSnapshot(documentSnapshot)).toList();
    });

    return requests;
  }
}