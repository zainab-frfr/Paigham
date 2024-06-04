import 'package:flutter/material.dart';
import 'package:paigham/pages/login.dart';
import 'package:paigham/pages/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  bool showLogin = true;

  void togglePage(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin){
      return MyLoginPage(onTap: togglePage,);
    }else{
      return MyRegisterPage(onTap: togglePage,);
    }
  }
}

// making this page to toggle between login and register made the app run smoother 
// using navigator.popandpushnamed looked ew