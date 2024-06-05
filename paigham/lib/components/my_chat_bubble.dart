import "package:flutter/material.dart";
import "package:paigham/themes/theme_provider.dart";
import "package:provider/provider.dart";

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const MyChatBubble({super.key, required this.message, required this.isCurrentUser});

  

  @override
  Widget build(BuildContext context) {

    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser? (isDarkMode? const Color.fromARGB(255, 142, 190, 144):const Color.fromARGB(255, 119, 188, 122)) : (isDarkMode? const Color.fromARGB(255, 47, 45, 45) :Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Text(message, style: const TextStyle(color: Colors.white),),
    );
  }
}