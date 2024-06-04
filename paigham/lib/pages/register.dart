import 'package:flutter/material.dart';
import 'package:paigham/services/auth/auth_services.dart';
import 'package:paigham/components/my_button.dart';
import 'package:paigham/components/my_textfield.dart';

class MyRegisterPage extends StatefulWidget {
  
  final void Function()? onTap;
  
  const MyRegisterPage({super.key, this.onTap});

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {

  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _password1 = TextEditingController();
  final TextEditingController _password2 = TextEditingController();
  final TextEditingController _username = TextEditingController();

  bool error = false;

  void _register() async {
    AuthServices auth = AuthServices();

    if(_password1.text == _password2.text){
      try {
        await auth.signUp(_emailControl.text, _password1.text, _username.text);
        error = false;
      } catch (e) {
        error = true;
      }
    }else{
      error = true;
    }

    setState(() {});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(Icons.message, size: 45.0,color: Theme.of(context).colorScheme.primary,),
          const SizedBox(height: 10,),

          Text("We've been waiting for you...", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,),),
          const SizedBox(height: 35.0,),

          MyTextField(hintText: "Username", obscureText: false,controller: _username,),
          const SizedBox(height: 20.0,),

          MyTextField(hintText: "Email", obscureText: false,controller: _emailControl,),
          const SizedBox(height: 20.0,),

          MyTextField(hintText: "Password", obscureText: true,controller: _password1,),
          const SizedBox(height: 20.0,),

          MyTextField(hintText: "Confirm Password", obscureText: true,controller: _password2,),
          

          if (error)            
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invalid email or password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 230, 124, 116),
                  )
                )
              ],
            ),

          if(!error)
            const SizedBox(height: 30.0,),
          MyButton(text: "Sign up", ontap: _register,),
          const SizedBox(height: 20.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account? ',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
              GestureDetector(
                onTap: widget.onTap,
                child: Text('Sign in.', style: TextStyle(fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.primary),)
              ),
            ],
          ),
        ],
      ),
    );
  }
}