import 'package:flutter/material.dart';
import 'package:paigham/components/my_drawer.dart';
import 'package:paigham/components/user_tile.dart';
import 'package:paigham/pages/chat.dart';
import 'package:paigham/services/auth/auth_services.dart';
import 'package:paigham/services/chat/chat_services.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  //chat and auth service instance
  final ChatServices _chatService = ChatServices();
  final AuthServices _authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const MyDrawer(),
      body: _userList(context),
    );
  }

  Widget _userList(BuildContext context) {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (constext, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text('Error');
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }

          //usersList
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return MyUserTile(
        text: userData["username"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyChatPage(
                        receiverEmail: userData["email"],
                        recieverUsername: userData["username"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
