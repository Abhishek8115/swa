import 'package:flutter/material.dart';
import 'package:swap/Models/chat_users.dart';
import 'package:swap/Widgets/chat.dart';

class Business_ChatPage extends StatefulWidget {
  @override
  _Business_ChatPageState createState() => _Business_ChatPageState();
}

class _Business_ChatPageState extends State<Business_ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      text: "Jane Russel",
      image: "assets/images/userImage1.jpeg",
    ),
    ChatUsers(
      text: "Glady's Murphy",
      image: "assets/images/userImage2.jpeg",
    ),
    ChatUsers(
      text: "Jorge Henry",
      image: "assets/images/userImage3.jpeg",
    ),
    ChatUsers(
      text: "Philip Fox",
      image: "assets/images/userImage4.jpeg",
    ),
    ChatUsers(
      text: "Debra Hawkins",
      image: "assets/images/userImage5.jpeg",
    ),
    ChatUsers(
      text: "Jacob Pena",
      image: "assets/images/userImage6.jpeg",
    ),
    ChatUsers(
      text: "Andrey Jones",
      image: "assets/images/userImage7.jpeg",
    ),
    ChatUsers(
      text: "John Wick",
      image: "assets/images/userImage8.jpeg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chats",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        // actions: [
        //   Icon(Icons.notifications,color: Colors.black,size: 20,),
        //   SizedBox(width: 20,),
        // ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //SizedBox(height: 20,),
            // SafeArea(
            //   child: Padding(
            //     padding: EdgeInsets.only(left: 16,right: 16,top: 10),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         Container(
            //           padding: EdgeInsets.only(left: 8,right: 8,top: 2,bottom: 2),
            //           height: 30,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(30),
            //             color: Colors.pink[50],
            //           ),
            //           child: Row(
            //             children: <Widget>[
            //               Icon(Icons.notifications,color: Colors.pink,size: 20,),
            //               // SizedBox(width: 2,),
            //               // Text("New",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatUsersList(
                  text: chatUsers[index].text,
                  image: chatUsers[index].image,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
