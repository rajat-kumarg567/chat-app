import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/componants/chat_bubble.dart';
import 'package:food_app/componants/my_textfields.dart';
import 'package:food_app/services/auth/auth_service.dart';
import 'package:food_app/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key,
  required this.receiverEmail,
  required this.receiverID});

  final TextEditingController _messageController=TextEditingController();
  final ChatService _chatService=ChatService();
  final AuthService _authService=AuthService();

  void sendMessage() async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(receiverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Column(
        children: [
          //display all the message
          Expanded(child:_buildMessageList() ),

          //user input
          _buildUserInput(),
        ],
      ),
    );
  }
  Widget _buildMessageList(){
    String senderID=_authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Text("Errors");
          }

          if(snapshot.connectionState==ConnectionState.waiting){
            return Text("Loading..");
          }

          return ListView(
            children: snapshot.data!.
            docs.map((doc)=>_buildMessageItem(doc)).toList(),

          );
        }
    );

  }
  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String , dynamic> data=doc.data() as Map<String , dynamic>;
  //is current user
    bool isCurrentUser=data['senderID']==_authService.getCurrentUser()!.uid;

    //align the message to the right if the sender is current user
    var alignment=isCurrentUser?Alignment.centerRight :Alignment.centerLeft;


    return Container(
      alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
           
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser)
          ],
        ));
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(child: myTextFields(
            controller: _messageController,
            hintText: "Type a message",
             isObscure: false,
          )),

          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
              margin: EdgeInsets.only(right: 25.0),
              child: IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_upward,
                color: Colors.white,
              ))),
        ],
      ),
    );
  }
}
