import 'package:cloud_firestore/cloud_firestore.dart'; // for connecting to cloud firestore in Firebase
import 'package:impact/models/user.dart';
import 'package:impact/services/user_service.dart';
import 'package:impact/models/request.dart';
import 'dart:async';

class RequestService {
  final Duration timeout = const Duration(seconds: 30);

  static Future<Request> submitRequest(Request request) async {
    Map map = request.toMap();
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      request.reference = await Firestore.instance.collection('request').add(map);
    });

    return Request.fromSnapshot(await request.reference.get());
  }

  static Future<Request> acceptRequest(Request request) async {
    request.status = 1;
    request = await updateRequest(request);
    User mentor = await UserService.getUser(request.mentor.id);
    mentor.mentees.add(request.mentee.id);
    User mentee = await UserService.getUser(request.mentee.id);
    mentee.mentors.add(request.mentor.id);
    mentor = await UserService.updateUser(mentor);
    mentee = await UserService.updateUser(mentee);
    return request;
  }

  static Future<Request> denyRequest(Request request) async {
    request.status = 2;
    request = await updateRequest(request);
    return request;
  }

  static Future<void> removeRequest(Request request) async {
    await Firestore.instance.runTransaction((Transaction tx,  {timeout}) async {
      await request.reference.delete();
    });    
  }

  static Future<Request> updateRequest(Request request) async {
    await Firestore.instance.runTransaction((Transaction tx, {timeout}) async {
      await request.reference.updateData(request.toMap());
    });
    
    return request;
  }

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