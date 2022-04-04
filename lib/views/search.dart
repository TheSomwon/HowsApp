import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:howsapp/functions/database.dart';
import 'package:howsapp/widget/widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late Map<String, dynamic>userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();

  void onSearch() async{

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore.collection("Utilisateur").where("USERNAME", isEqualTo: _search.text).get()
    .then((value){
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }



  TextEditingController searchTextEdetingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : Container(
        child: Column(
          children: [
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: _search,
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            hintText: "search username",
                            hintStyle: TextStyle(
                                color: Colors.white54
                            ),
                            border: InputBorder.none
                        ),
                      )
                  ),
                  GestureDetector(
                    onTap: onSearch,
                    child: Container(
                      height: 40,
                    width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0x36FFFFFF),
                            const Color(0x0FFFFFFF)
                          ]
                        ),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Image.asset("assets/images/search_white.png"),
                    ),
                  ),
                  // ListTile(
                  //   onTap: (){
                  //
                  //   },
                  //   leading: Icon(Icons.account_box, color: Colors.white,),
                  //   title: Text(userMap['USERNAME'],
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 16
                  //   ),),
                  //   subtitle: Text(userMap['EMAIL']),
                  //   trailing: Icon(Icons.chat, color: Colors.white,),
                  // )
                ],
              )

            ),
            // userList(),
          ],
        ),
      ),
    );
  }
}



// class userTile extends StatelessWidget {
//
//   final String userName;
//   final String userEmail;
//   SearchTile({required this.userName, required this.userEmail});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Text(userName, style: simpleTextStyle(),),
//               Text(userEmail, style: simpleTextStyle(),),
//             ],
//           ),
//           Spacer(),
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(30)
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Text("Message"),
//           )
//         ],
//       ),
//     );
//   }
// }

