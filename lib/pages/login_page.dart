import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:food_app/componants/my_button.dart';
import 'package:food_app/componants/my_textfields.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final _emailController=TextEditingController();
  final _passController=TextEditingController();
  void Function()? onTap;
   LoginPage({super.key,required this.onTap});
void login(BuildContext context) async{
  final authService=AuthService();
  try{
    await authService.signInWithEmailPassword(_emailController.text, _passController.text);
  }catch(e){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(e.toString()),
    ));
  }
  //
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
        
              const SizedBox(
                height: 50,
              ),
        
              //welcome
              Text(
                "Welcome back,you've missed",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        
              const SizedBox(
                height: 50,
              ),
        
              myTextFields(hintText: "email..",
              
              controller: _emailController, isObscure: false,),
        
              const SizedBox(
                height: 30,
              ),
        
              myTextFields(hintText: "password..",
              controller: _passController, isObscure: true,),
              
              SizedBox(
                height: 30,
              ),
              
              myButton(text: "Login ",onTap: ()=>login(context),),
        
              SizedBox(
                height: 20,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("don't have an account?",style: TextStyle(color:Theme.of(context).colorScheme.primary ),),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Register Now",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
        
        
            ],
          ),
        ),

    )
    ;
  }
}
