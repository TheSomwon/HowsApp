import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:howsapp/functions/database.dart';
import 'package:howsapp/widget/widget.dart';

import '../functions/constants.dart';
import '../functions/helperfunctions.dart';


class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  late String myName, myProfilePic, myUserName, myEmail, chatRoomId;

  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageEditingController = new TextEditingController();

  late Stream messageStream;

  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
              padding: EdgeInsets.only(bottom: 70, top: 16),
              itemCount: snapshot.data!.docs.length,
              reverse: true,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return chatMessageTile(
                    ds["message"], myUserName == ds["sendBy"]);
              })
              : Center(child: CircularProgressIndicator());
        });
  }
  
  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getConversationMessages(widget.chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  getMyInfoFromSharedPreference() async {
    // myName = await HelperFunctions.sharedPreferenceUserNameKey;
    // myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await HelperFunctions.sharedPreferenceUserNameKey;
    myEmail = await HelperFunctions.sharedPreferenceUserEmailKey;

    chatRoomId = widget.chatRoomId;
  }


  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
      sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                  sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                  sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Colors.blue : Color(0xfff1f0f0),
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }


  sendMessage(){
    if(messageEditingController.text.isNotEmpty){
      Map<String, String> messageMap = {
        "message":messageEditingController.text,
        "sendBy": Constants.myName
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
    }

  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageEditingController,
                          onChanged: (value) {

                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "type a message",
                              hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.6))),
                        )),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


