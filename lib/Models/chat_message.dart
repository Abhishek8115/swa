import 'package:flutter/cupertino.dart';
import 'package:swap/Screens/Chat_Details_Screen.dart';

class ChatMessage{
  String message;
  MessageType type;
  ChatMessage({@required this.message,@required this.type});
}