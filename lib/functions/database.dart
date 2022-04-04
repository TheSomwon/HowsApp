

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance.collection("Utilisateur").
    where("USERNAME", isEqualTo: username).snapshots();
  }
}