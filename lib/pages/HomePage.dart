import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/services/chat/chat_service.dart';


import '../componants/my_drawer.dart';
import '../componants/user_tile.dart';
import '../services/auth/auth_service.dart';
import 'chat_page.dart';

class Homepage extends StatelessWidget {
   Homepage({super.key});
  final ChatService _chatService=ChatService();
  final AuthService _authService=AuthService();

  void logout(){
  final _auth=AuthService();
  _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title:  Text("Home",),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer:MyDrawer(),
      body: _builderUserList(),
    );
  }
  Widget _builderUserList(){
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context,snapshot){
           if(snapshot.hasError){
             return const Text("Error");
           }
           if(snapshot.connectionState==ConnectionState.waiting){
             return const Text("Loading");
           }
           return ListView(
             children: snapshot.data!.map<Widget>(
                     (userData)=>_buildUserListItem(userData,context)).toList()
           );


        }
    );
  }
  Widget _buildUserListItem(Map<String,dynamic> userData,BuildContext context){
    if(userData["email"]!=_authService.getCurrentUser()!.email) {
      return UserTile(
          text: userData["email"],
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                )));
          }
      );
    }else{
      return Container();
    }
  }
}
