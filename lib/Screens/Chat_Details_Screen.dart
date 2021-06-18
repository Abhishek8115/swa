import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swap/Models/chat_message.dart';
import 'package:swap/Widgets/chat_bubble.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
enum MessageType{
  Sender,
  Receiver,
}
List messageData = [];

class ChatDetailPage extends StatefulWidget{
  @override
  String owner_id;
  ChatDetailPage({Key key, this.owner_id}): super(key: key);
  _ChatDetailPageState createState() => _ChatDetailPageState();
}
class _ChatDetailPageState extends State<ChatDetailPage> {

  TextEditingController typedMsg = TextEditingController();
  List<ChatMessage> chatMessage = [
    ChatMessage(message: "Hi John", type: MessageType.Receiver),
    ChatMessage(message: "Hope you are doin good", type: MessageType.Receiver),
    ChatMessage(message: "Hello Jane, I'm good what about you", type: MessageType.Sender),
    ChatMessage(message: "I'm fine, Working from home", type: MessageType.Receiver),
    ChatMessage(message: "Oh! Nice. Same here man", type: MessageType.Sender),
  ];
  Directory directory;
  Stream message;
  File file2;
  String userId ;
  String chatRoomId;
  createChatRoom(ownerid) async{
    // await getMetaData();
    directory = await getApplicationDocumentsDirectory();
    file2 = File('${directory.path}/userId.txt');
    userId = await file2.readAsString();
    print("userId :"+userId);
    print("ownerId :"+widget.owner_id);
    chatRoomId = getChatRoomId(userId, widget.owner_id);
    List<String> users = [userId, ownerid];
    Map<String, dynamic> chatRoomMap = {
      "users": users,
      "chatroomId": chatRoomId
    };
    Firestore.instance.collection('ChatRoom')
      .document(chatRoomId)
      .setData(chatRoomMap)
      .catchError((onError)=> print(onError.toString()));
  }
  addConversationMessages( text){
    chatRoomId  = getChatRoomId(userId, widget.owner_id);
    Map<String, dynamic> messageMap = {
      "message": text,
      "sendBy": userId,
      "time": DateTime.now().millisecondsSinceEpoch
    };
    Firestore.instance.collection("ChatRoom")
      .document(chatRoomId)
      .collection("chats")
      .add(messageMap).catchError((onError)=> print(onError.toString()));
  }
  getConversationMessages(String chatRoomId)async {
    return await Firestore.instance.collection("ChatRoom")
      .document(chatRoomId)
      .collection("chats")
      .orderBy("time", descending: false)
      .snapshots();
  }

  getChatRoomId(String a,String b){
    print("a :"+ a);
    print("b :"+b);
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0))
      return "$b\_$a";
    return "$a\_$b";
  }
  getMetaData()async{    
    print("userId :"+userId);
    print("ownerId :"+widget.owner_id);
  }
  @override
  void initState() {    
    // getMetaData();
    createChatRoom( widget.owner_id);
    getConversationMessages(chatRoomId).then((value){
      setState(() {
        message = value;
        print(message.isEmpty);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //_socket.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Chat", style: TextStyle(color: Colors.black)),
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.purple[50],
      ),
      body: Stack(        
        children: <Widget>[
          StreamBuilder(
            stream: message,
            builder: (context, snapshot){
              
              if(snapshot.data == null){ 
                getConversationMessages(chatRoomId).then((value){
                  setState(() {
                    message = value;
                    print(message.isEmpty);
                  });
                });
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 10,bottom: 10),
              physics: BouncingScrollPhysics(), 
              itemBuilder: (context, index){
                // messageData.add({
                //   "message": snapshot.data.documents[index].data["message"],
                //   "userId": snapshot.data.documents[index].data['sendBy']
                // });
                chatMessage.add(ChatMessage(
                  message: snapshot.data.documents[index].data["message"],
                  type: userId == snapshot.data.documents[index].data['sendBy']? MessageType.Sender: MessageType.Receiver
                  )
                );
                print("message : "+snapshot.data.documents[index].data["message"]);
                return ChatBubble(chatMessage: ChatMessage(
                  message: snapshot.data.documents[index].data["message"],
                  type: userId == snapshot.data.documents[index].data['sendBy']? MessageType.Sender: MessageType.Receiver
                  ));
              },
            );
            }
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16,bottom: 10),
              height: 80,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: typedMsg,
                      //focusNode: FocusNode.
                      decoration: InputDecoration(
                          hintText: "Type message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.only(right: 30,bottom: 50),
              child: FloatingActionButton(
                onPressed: ()async{
                  // chatMessage.add(
                  //   ChatMessage(
                  //     message:typedMsg.text.trim(),
                  //     type: MessageType.Sender )
                  //   );
                  //sendMessage(typedMsg.text);
                  //initSocket("true");
                  // createChatRoom(userId, widget.owner_id);
                  addConversationMessages(typedMsg.text);
                  setState(() {
                    typedMsg.clear();
                  });                  
                },
                child: Icon(Icons.send,color: Colors.white,),
                backgroundColor: Colors.purple[300],
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }
}