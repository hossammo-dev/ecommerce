import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static late FirebaseAuth _auth;

  static late FirebaseFirestore _database;

  static initFirebase() {
    _auth = FirebaseAuth.instance;
    _database = FirebaseFirestore.instance;
  }

  //Firebase Auth

  //login
  Future<String> login({required String email, required String password}) =>
      _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((user) => user.user!.uid);

  //register
  Future<String> register(String? username, String? phoneNumber, String? email,
          String? password) =>
      _auth
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((user) => user.user!.uid);

  //singOut
  Future<void> logOut() async => await _auth.signOut();

  //Firebase Firestore

  //save data
  Future<void> save(
          {required String collection,
          required Map<String, dynamic> data,
          required String docId}) async =>
      await _database.collection(collection).doc(docId).set(data);

  Future<DocumentSnapshot<Map<String, dynamic>>> get(
          {required String collection, required String docId}) async =>
      _database.collection(collection).doc(docId).get();
}
