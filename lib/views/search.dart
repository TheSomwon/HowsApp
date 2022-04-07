import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:howsapp/functions/constants.dart';
import 'package:howsapp/functions/database.dart';
import 'package:howsapp/views/conversation.dart';
import 'package:howsapp/widget/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late Map<String, dynamic>userMap;
  bool isLoading = false;
  bool haveUserSearched = false;
  TextEditingController searchTextEdetingController = new TextEditingController();
  late int numberOfValue;
  late String userName;
  late String userEmail;

  void onSearch() async{

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    if(searchTextEdetingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
    }
    await _firestore.collection("Utilisateur").where("USERNAME", isEqualTo: searchTextEdetingController.text).get()
    .then((value){
      setState(() {
        numberOfValue = value.docs.length;
        userMap = value.docs[0].data();
        userName = userMap['USERNAME'];
        userEmail = userMap['EMAIL'];
        print(userName);
        isLoading = false;
        haveUserSearched = true;
      });
      print(userMap);
    });
  }

  Widget userList(){
    return haveUserSearched ? ListView.builder(
        shrinkWrap: true,
        itemCount: numberOfValue,
        itemBuilder: (context, index){
          return userTile(
            userName,
            userEmail
          );
        }) : Container();
  }

  CreateChatroomAndStartConversation(String userName){

    if(userName != Constants.myName){

      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];
      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomid": chatRoomId
      };

      DatabaseMethods().createChatroom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)));
    }else{
      print("can't talk to yourself");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :  Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0x54FFFFFF),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextEdetingController,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                          hintText: "search username ...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      onSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight
                            ),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png",
                          height: 25, width: 25,)),
                  )
                ],
              ),
            ),
            userList()
          ],
        ),
      ),
    );
  }




  Widget userTile(String userName,String userEmail){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              CreateChatroomAndStartConversation(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: Text("Message",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          )
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
