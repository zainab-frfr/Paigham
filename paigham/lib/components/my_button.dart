import 'package:flutter/material.dart';
import "package:paigham/themes/theme_provider.dart";
import "package:provider/provider.dart";

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;
  
  const MyButton({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(child: Text(text, style:  TextStyle(color: isDarkMode? const Color.fromARGB(255, 230, 224, 224):Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}