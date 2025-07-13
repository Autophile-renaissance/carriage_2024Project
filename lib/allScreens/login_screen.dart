import 'dart:async';

import 'package:carriage_app/allScreens/main_screen.dart';
import 'package:carriage_app/allScreens/registration_screen.dart';
import 'package:carriage_app/allWidgets/progress_dialogue.dart';
import 'package:carriage_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String idScreen= 'login';
   final TextEditingController emailController=TextEditingController();
    final TextEditingController passwordController=TextEditingController();

final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;

Future  <void> loginUser(BuildContext context) async{
  showDialog(context: context,
   builder: (BuildContext context)
   {
  return  ProgressDialogue(message: "Authenticating wait please",);
   },
   barrierDismissible: false
   );



final firebaseUser=(await _firebaseAuth
.signInWithEmailAndPassword
(email: emailController.text, password: passwordController.text)
  .catchError((errMsg){
    Navigator.pop(context);
  return  displayToastMessage("Error"+errMsg.toString(), context);
   })).user;

if(firebaseUser!=null){
  //user created 
  //save user info to database


usersRef.child(firebaseUser.uid).get().then((DataSnapshot snap)
{
  
  if(snap.value!=null){

 Navigator.pushNamedAndRemoveUntil(context ,MainScreen.idScreen, (route)=>false);
  }
  else{
    Navigator.pop(context);
    _firebaseAuth.signOut();
    displayToastMessage("No such user exists.Please register", context);
  }
} );



}
else{
  //error occured -display error
  Navigator.pop(context);
  displayToastMessage("New user account has not been created",context);
}


}

displayToastMessage(String message , BuildContext context){
  Fluttertoast.showToast(msg: message);
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 45.0, ),
          Image(image: AssetImage('images/CARRIAGE(2).png'),
          width: 350.0,
          height: 250.0,
          alignment: Alignment.center,),
          SizedBox(height: 15.0,),
          Text("Login as Dispatcher", style: TextStyle(
            fontSize: 24.0,
            fontFamily: "Brand Bold",
           
          ),textAlign: TextAlign.center,),
        
          Padding(padding: EdgeInsets.all(20.0), child: Column(
            children: [
              SizedBox( height: 1.0,),
               TextFormField(
                controller: emailController,
            style: TextStyle( fontSize:14.0 ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
             labelText: 'Email',
             labelStyle: TextStyle(
              fontSize: 14.0,
        
             ),hintStyle: TextStyle(
              color:Colors.grey,
              fontSize: 10.0,
              
             ),
             
            ),
          ),
          SizedBox( height: 1.0,),
               TextFormField(
                controller: passwordController,
            style: TextStyle( fontSize:14.0 ),
            obscureText: true,
            decoration: InputDecoration(
             labelText: 'Password',
             labelStyle: TextStyle(
              fontSize: 14.0,
        
             ),hintStyle: TextStyle(
              color:Colors.grey,
              fontSize: 10.0,
              
             ),
             
            ),
          ),
          SizedBox(height: 38.0,),
          ElevatedButton(onPressed: (){
            if(!emailController.text.contains("@")){
              displayToastMessage("Email context is not valid", context);
            }
            else if(passwordController.text.isEmpty){
              displayToastMessage("Password is mandatory", context);
            }
          else{    loginUser(context);//a function that logins the users
          }
          },  child: Container(
            height: 50.0,
            child: Center(
              child: Text('login', style: TextStyle(fontSize: 18.0, fontFamily: 'Brand Bold', color: Colors.white),),
            ),
          ),
          style: ElevatedButton.styleFrom(
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            backgroundColor: Colors.yellow,
            
          ),
          )
               ],
          ),),
           TextButton(onPressed:(){
            Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen, (route)=>false);
           } , child: Text("Do not have an account ? Register here", style: TextStyle(fontFamily: 'Brand Bold' , color: Colors.black),), )
        
        
          
         
        ],),
      ),
    );
   
  }
}