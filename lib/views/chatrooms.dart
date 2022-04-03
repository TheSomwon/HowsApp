import 'package:flutter/material.dart';

import '../widget/widget.dart';

class chatrooms extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return chatroomsState();
  }
}
class chatroomsState extends State<chatrooms>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: bodyPage(),
    );
  }

   Widget bodyPage() {
      return Column(

      );
   }
}