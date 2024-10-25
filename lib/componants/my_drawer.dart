import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../pages/Setting_page.dart';
import '../services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    final _auth=AuthService();
    _auth.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child:Icon(Icons.message,
                  color: Theme.of(context).colorScheme.primary,
                  size: 40,),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("H O M E",style:TextStyle( color:Theme.of(context).colorScheme.primary),),
                  leading: Icon(Icons.home),
                  onTap: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: Text("SETTINGS",style:TextStyle( color:Theme.of(context).colorScheme.primary)),
                  leading: Icon(Icons.settings),
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>SettingPage()));
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: Text("LOGOUT",style:TextStyle( color:Theme.of(context).colorScheme.primary)),
              leading: Icon(Icons.logout),
              onTap:logout,
            ),
          ),
        //change1

        ],
      ),
    );
  }
}
