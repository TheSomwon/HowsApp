import 'package:flutter/material.dart';
import 'package:howsapp/widget/widget.dart';

import '../functions/firestoreHelper.dart';
import '../functions/helperfunctions.dart';

class signUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return signUpState();
  }
}

class signUpState extends State<signUp> {
  late String email;
  late String password;
  late String username;

  signMeUp(){
    Map<String, String> userInfomap ={
      "username": username,
      "email": email,
      "password": password
    };
    HelperFunctions.saveUserLoggedInSharedPreference(true);
    HelperFunctions.saveUserEmailSharedPreference(email);
    HelperFunctions.saveUserNameSharedPreference(username);

    FirestoreHelper().SignUp(email, password, username);
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
                username = val;
              });
            },
            decoration: textFieldInputDecoration("username"),
          ),
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
            style: simpleTextStyle(),
            obscureText: true,
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
                print("Je me suis inscris");
                signMeUp();
              },
              child: Text("Sing Up")
          ),
        ],
    );
  }
}
