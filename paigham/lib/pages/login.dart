import 'package:flutter/material.dart';
import 'package:paigham/services/auth/auth_services.dart';
import 'package:paigham/components/my_button.dart';
import 'package:paigham/components/my_textfield.dart';

class MyLoginPage extends StatefulWidget {
  final void Function()? onTap;

  const MyLoginPage({super.key, this.onTap});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _emailControl = TextEditingController();

  final TextEditingController _passwordControl = TextEditingController();

  bool error = false;

  void _login() async {
    AuthServices auth = AuthServices();
    try {
      await auth.signIn(_emailControl.text, _passwordControl.text);
      error = false;
    } catch (e) {
      error = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.message,
            size: 80.0,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(
            height: 30,
          ),

          Text(
            "Welcome back :D",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 50.0,
          ),

          MyTextField(
            hintText: "Email",
            obscureText: false,
            controller: _emailControl,
          ),

          const SizedBox(
            height: 20.0,
          ),

          MyTextField(
            hintText: "Password",
            obscureText: true,
            controller: _passwordControl,
          ),

          if (error)
            const SizedBox(height: 10,),
          if (error)            
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Incorrect email or password',
                  style: TextStyle(
                    color: Color.fromARGB(255, 230, 124, 116),
                  )
                )
              ],
            ),
          
          
          const SizedBox(
            height: 30.0,
          ),


          MyButton(
            text: "Login",
            ontap: _login,
          ),
          const SizedBox(
            height: 20.0,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account? ',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register now.',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.primary),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
