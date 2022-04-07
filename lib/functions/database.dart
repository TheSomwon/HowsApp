

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return FirebaseFirestore.instance.collection("Utilisateur").
    where("USERNAME", isEqualTo: username).snapshots();
  }

  createChatroom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("ChatRoom")
        .doc(chatRoomId).set(chatRoomMap).catchError((e){
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) async {
    return FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId)
        .collection("chats").add(messageMap).catchError((e){
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId)
        .collection("chats").snapshots();
  }

}