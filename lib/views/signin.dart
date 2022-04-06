
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:howsapp/functions/firestoreHelper.dart';
import 'package:howsapp/model/utilisateur.dart';
import 'package:howsapp/views/signup.dart';
import 'package:howsapp/widget/widget.dart';

import '../functions/helperfunctions.dart';
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
  late String userName;
  late Map<String, dynamic>userMap;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signMeIn() async{

    await _firestore.collection("Utilisateur").where("EMAIL", isEqualTo: email).get()
        .then((value){
          userMap = value.docs[0].data();
          userName = userMap["USERNAME"];
    });

    // HelperFunctions.saveUserNameSharedPreference();

    FirestoreHelper().SignIn(email, password).then((value) {
      print("je me suis co");

      HelperFunctions.saveUserEmailSharedPreference(email);
      HelperFunctions.saveUserNameSharedPreference(userName);
      HelperFunctions.saveUserLoggedInSharedPreference(true);


      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context){
            return chatrooms();
          }
      ));
    });
  }

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
                signMeIn();
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
