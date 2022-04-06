
import 'package:flutter/material.dart';
import 'package:howsapp/functions/firestoreHelper.dart';
import 'package:howsapp/views/signup.dart';
import 'package:howsapp/widget/widget.dart';

import 'chatrooms.dart';

class signIn extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return signInState();
  }
}

class signInState extends State<signIn> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
        child: bodyPage(),
      ),
    );
  }
  Widget bodyPage() {
    return Column(
        children: [
          TextField(
            style: simpleTextStyle(),
            onChanged: (val){
              setState(() {
                email = val;
              });
            },
            decoration: textFieldInputDecoration("email"),
          ),
          TextField(
            obscureText: true,
            style: simpleTextStyle(),
            onChanged: (val){
              setState(() {
                password = val;
              });
            },
            decoration: textFieldInputDecoration("password"),
          ),
          SizedBox(height: 16,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              onPressed: (){
                FirestoreHelper().SignIn(email, password).then((value) {
                  print("je me suis co");

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context){
                        return chatrooms();
                      }
                  ));
                });
              },
              child: Text("Sign In")
          ),
          InkWell(
            child: Text("New account",style: TextStyle(color: Colors.blue),),
            onTap: (){
              print("J'ai tappé une fois");
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context){
                    return signUp();
                  }));
            },
          )
        ],
    );
  }
}
