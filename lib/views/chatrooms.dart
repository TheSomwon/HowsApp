import 'package:flutter/material.dart';
import 'package:howsapp/functions/firestoreHelper.dart';
import 'package:howsapp/views/search.dart';
import 'package:howsapp/views/signin.dart';

import '../widget/widget.dart';

class chatrooms extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return chatroomsState();
  }
}
class chatroomsState extends State<chatrooms>{

  FirestoreHelper firestoreHelper = new FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
            "assets/images/title.png",
            height: 60,),
        actions: [
          GestureDetector(
            onTap: (){
              firestoreHelper.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => signIn())
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchScreen()));
        },
      ),
    );
  }

   Widget bodyPage() {
      return Column(

      );
   }
}