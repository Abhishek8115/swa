import 'dart:convert';
import 'dart:ffi';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swap/Models/chat_message.dart';
import 'package:swap/Widgets/chat_bubble.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;
// import 'package:web_socket_channel/io.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
// import 'data.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
enum MessageType{
  Sender,
  Receiver,
}

class ChatDetailPage extends StatefulWidget{
  @override
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
  //WebSocketChannel _channel;
  SocketIOManager manager;
  Map<String, SocketIO> sockets = {};
  final _isProbablyConnected = <String, bool>{};
  void sendMessage(String message)async{
    
    // print("printing token");
    // print("token :$token");
    // print('reached here');
    
  }
  Future<void> initSocket(String identifier)async{
    print("hemlo");
    Directory directory = await getApplicationDocumentsDirectory();
    File file3 = File('${directory.path}/token.txt');
    String token = await file3.readAsString();
    SocketIO socket = await manager.createInstance(SocketOptions(
      "https://food2swap.herokuapp.com/api",
      query: {
        'Authorization': 'Bearer $token'
      },
      enableLogging: true,
      transports: [Transports.webSocket]
    ));    
    print('reached here');
    socket.onConnectTimeout.listen((data){
      print("Error : ${data.toString()}");
    });
    socket.onConnectError.handleError((onError)=>print(onError));
    socket.connect();
    socket.onConnecting.listen((data)=> print("connecting"));
    socket.isConnected().then((onValue)=> print(onValue.toString()));
    socket.onConnect.listen((data){
      print('Connected : ${data.toString()}');
    });
    socket.emit("message", ["hey there"]);
    socket.isConnected().then((onValue)=> print(onValue.toString()));
  }
  @override
  void initState() {
    super.initState();
    manager = SocketIOManager();
    initSocket("true");
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
          ListView.builder(
            itemCount: chatMessage.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10,bottom: 10),
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index){
              return ChatBubble(
                chatMessage: chatMessage[index],
              );
            },
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
                onPressed: (){
                  // chatMessage.add(
                  //   ChatMessage(
                  //     message:typedMsg.text.trim(),
                  //     type: MessageType.Sender )
                  //   );
                  //sendMessage(typedMsg.text);
                  initSocket("true");
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