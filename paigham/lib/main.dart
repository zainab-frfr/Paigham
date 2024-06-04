import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paigham/services/auth/auth_gate.dart';
import 'package:paigham/services/auth/login_or_register.dart';
import 'package:paigham/firebase_options.dart';
import 'package:paigham/pages/login.dart';
import 'package:paigham/pages/register.dart';
import 'package:paigham/pages/settings.dart';
import 'package:paigham/themes/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightmode,
      initialRoute: '/authGate',
      routes: {
        '/authGate': (context) => const AuthGate(),
        '/loginOrReg':(context) => const LoginOrRegister(),
        '/login': (context) => const MyLoginPage(),
        '/register': (context) => const MyRegisterPage(),
        '/settings':(context) => const MySettingsPage(),
      },
    );
  }
}

