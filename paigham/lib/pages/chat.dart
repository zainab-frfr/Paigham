import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paigham/components/my_textfield.dart';
import 'package:paigham/services/auth/auth_services.dart';
import 'package:paigham/services/chat/chat_services.dart';

class MyChatPage extends StatelessWidget {
  final String receiverEmail;
  final String recieverUsername;
  final String receiverID;

  MyChatPage(
      {super.key,
      required this.receiverEmail,
      required this.recieverUsername,
      required this.receiverID});

  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatService = ChatServices();
  final AuthServices _authService = AuthServices();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recieverUsername),
      ),
      body: Column(
        children: [
          // display all the messages
          Expanded(child: _buildMessageList()),
          _buildUserInput(context),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String currUserID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(currUserID, receiverID),
        builder: ((context, snapshot) {
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
            children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );
        }));
  }

  Widget _buildMessageItem(DocumentSnapshot doc){

    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var allignment = isCurrentUser? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: allignment,
      child: Text(data['message'])
      );

  }

  Widget _buildUserInput(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(children: [
        Expanded(
          child: MyTextField(
            hintText: "Type a message", obscureText: false, controller: _messageController)
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).colorScheme.primary,
          ),
          margin: const EdgeInsets.only(right: 25),
          child: IconButton(onPressed: sendMessage, icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary))),
      ]
        
        ),
    );
  }
}
