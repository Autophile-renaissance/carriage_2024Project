import 'package:carriage_app/allScreens/login_screen.dart';
import 'package:carriage_app/allScreens/main_screen.dart';
import 'package:carriage_app/allWidgets/progress_dialogue.dart';
import 'package:carriage_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegistrationScreen extends StatelessWidget {
   RegistrationScreen({super.key});
  static const String idScreen= 'register';
  final TextEditingController nameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController phoneController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  

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
          Text("Register as Dispatcher", style: TextStyle(
            fontSize: 24.0,
            fontFamily: "Brand Bold",
           
          ),textAlign: TextAlign.center,),
        
          Padding(padding: EdgeInsets.all(20.0), child: Column(
            children: [
              SizedBox( height: 1.0,),
               TextFormField(
               controller: nameController, 
            style: TextStyle( fontSize:14.0 ),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
             labelText: 'Name',
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
                controller: emailController ,
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
                controller: phoneController,
            style: TextStyle( fontSize:14.0 ),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
             labelText: 'Phone',
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
          SizedBox( height: 1.0,),
               TextFormField(
            style: TextStyle( fontSize:14.0 ),
            obscureText: true,
            decoration: InputDecoration(
             labelText: 'Confirmed password',
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
            if(nameController.text.length <4 ){
            displayToastMessage("Name must be at least 3 characters", context);
            }
            else if(!emailController.text.contains("@")){
              displayToastMessage("Email context is not valid", context);
            }
            else if(phoneController.text.isEmpty){
              displayToastMessage("Phone number is mandatory", context);
            }
            else if(passwordController.text.length <8 )
            {
              displayToastMessage("Password must be at least 8 characters", context);
            }

            else
             {
              registerUsers(context); //ensures that each time it is clicked users are registered
             }
          },  child: Container(
            height: 50.0,
            child: Center(
              child: Text('Create an account', style: TextStyle(fontSize: 18.0, fontFamily: 'Brand Bold', color: Colors.white),),
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
            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route)=>false);
           } , child: Text("Already have an account ? Login here", style: TextStyle(fontFamily: 'Brand Bold' , color: Colors.black),), )
        
        
          
         
        ],),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


//allows users to be registeres 

 void registerUsers(BuildContext context)async
  {

  showDialog(context: context,
   builder: (BuildContext context)
   {
  return  ProgressDialogue(message: "Registering wait please",);
   },
   barrierDismissible: false
   );




   final  firebaseUser = (await  _firebaseAuth
   .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
   .catchError((errMsg){
    Navigator.pop(context);
  return  displayToastMessage("Error"+errMsg.toString(), context);
   })).user; 
if(firebaseUser!=null){
  //user created 
  //save user info to database

Map userDataMap={
  "name":nameController.text.trim(),
  "email":emailController.text.trim(),
  "phone":phoneController.text.trim(),
  "password":passwordController.text,
};
usersRef.child(firebaseUser.uid).set(userDataMap);

displayToastMessage("Successfull Registration", context);
Navigator.pushNamedAndRemoveUntil(context ,MainScreen.idScreen, (route)=>false);

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

}