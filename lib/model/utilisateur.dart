

import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur{
  String id = "";
  String? avatar;
  String email = "";
  String username = "";

  Utilisateur(DocumentSnapshot snapshot){
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    avatar = map["AVATAR"];
    email = map["EMAIL"];
    username = map["USERNAME"];
  }

  Utilisateur.vide();
}