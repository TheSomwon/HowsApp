import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:howsapp/model/utilisateur.dart';

class FirestoreHelper{
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("Utilisateur");
  final fireStorage = FirebaseStorage.instance;

  Future SignUp(String email, String password, String username) async{
    UserCredential result = await auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;
    String uid = user!.uid;
    Map<String, dynamic>map = {
      "EMAIL": email,
      "USERNAME": username,
      "PASSWORD": password
    };
    addUser(uid, map);
  }

  Future SignIn(String email, String password) async{
    UserCredential result = await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  addUser(String uid, Map<String, dynamic>map) {
    fire_user.doc(uid).set(map);
  }

  updatedUser(String uid,Map<String,dynamic>map){
    fire_user.doc(uid).update(map);
  }

  Future <String> getIdentifiant() async{
    String uid = auth.currentUser!.uid;
    return uid;
  }

  Future <Utilisateur> getUtilisateur(String uid) async {
    DocumentSnapshot  snapshot = await fire_user.doc(uid).get();
    return Utilisateur(snapshot);
  }

  Future <String> stockageImage(String nameFile,Uint8List datas) async{
    TaskSnapshot snapshot = await fireStorage.ref("image/$nameFile").putData(datas);
    String urlChemin = await snapshot.ref.getDownloadURL();
    return urlChemin;
  }
}