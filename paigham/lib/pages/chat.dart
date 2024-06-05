import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paigham/components/my_chat_bubble.dart';
import 'package:paigham/components/my_textfield.dart';
import 'package:paigham/services/auth/auth_services.dart';
import 'package:paigham/services/chat/chat_services.dart';
import 'package:paigham/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class MyChatPage extends StatefulWidget {
  final String receiverEmail;
  final String recieverUsername;
  final String receiverID;

  MyChatPage(
      {super.key,
      required this.receiverEmail,
      required this.recieverUsername,
      required this.receiverID});

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  final TextEditingController _messageController = TextEditingController();

  final ChatServices _chatService = ChatServices();

  final AuthServices _authService = AuthServices();

  FocusNode myFocusNode = FocusNode(); //for textfield focus

  @override
  void initState() {
    super.initState();

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(widget.recieverUsername),
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
        stream: _chatService.getMessages(currUserID, widget.receiverID),
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
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        }));
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var allignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: allignment,
      child:
          MyChatBubble(message: data["message"], isCurrentUser: isCurrentUser),
    );
  }

  Widget _buildUserInput(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(children: [
        Expanded(
            child: MyTextField(
          hintText: "Type a message",
          obscureText: false,
          controller: _messageController,
          focusNode: myFocusNode,
        )),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isDarkMode
                  ? const Color.fromARGB(255, 142, 190, 144)
                  : const Color.fromARGB(255, 119, 188, 122),
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send,
                    color: Theme.of(context).colorScheme.secondary))),
      ]),
    );
  }
}
