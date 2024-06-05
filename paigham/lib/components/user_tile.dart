import 'package:flutter/material.dart';
import "package:paigham/themes/theme_provider.dart";
import "package:provider/provider.dart";

class MyUserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap; 
  
  const MyUserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.person, color: isDarkMode? const Color.fromARGB(255, 212, 209, 209): Colors.black,), 
            const SizedBox(width: 20,),
            Text(text, style: TextStyle(color: isDarkMode? Colors.white: Colors.black),)
          ],
        ),
      ),
    );
  }
}