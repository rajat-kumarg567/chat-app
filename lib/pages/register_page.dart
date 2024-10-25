import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../componants/my_button.dart';
import '../componants/my_textfields.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final _emailController=TextEditingController();
  final _passController=TextEditingController();
  final _confirmpwController=TextEditingController();
  void Function()? onTap;
   RegisterPage({super.key,required this.onTap});

  void register(BuildContext context)async{
    
    final _auth=AuthService();
    if(_passController.text==_confirmpwController.text){
      try {
        _auth.signUpWithEmailPassword(
            _emailController.text, _passController.text);
      } catch(e){
        showDialog(context: context, builder: (context)=>AlertDialog(
          title: Text(e.toString()),
        ));
      }
    }else{
      showDialog(context: context, builder: (context)=>AlertDialog(
        title: const Text("Psssword do not match"),
      ));
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
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
                "Let's create an account for you",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
        
              const SizedBox(
                height: 50,
              ),
        
              myTextFields(hintText: "email..",
                isObscure: false,
                controller: _emailController,),
        
              const SizedBox(
                height: 30,
              ),
        
              myTextFields(hintText: "password..",
                isObscure: true,
                controller: _passController,),
        
              const SizedBox(
                height: 30,
              ),
        
              myTextFields(hintText: "confirm pass..",
                isObscure: true,
                controller: _confirmpwController,),
        
              SizedBox(
                height: 30,
              ),
        
              myButton(text: "Register ",onTap: ()=>register(context),),
        
              SizedBox(
                height: 20,
              ),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(color:Theme.of(context).colorScheme.primary ),),
                  GestureDetector(
                    onTap:onTap ,
                    child: Text("Login Now",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
        
        
            ],
          ),
        ),
      ),
    );
  }
}
