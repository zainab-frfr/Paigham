import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paigham/models/message.dart';

class ChatServices {
  //instance firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverID, message) async {
    //current user
    final String currUserID = _auth.currentUser!.uid;
    final String currUserEmail = _auth.currentUser!.email!;

    final Timestamp timestamp = Timestamp.now();

    //new message
    Message newMessage = Message(currUserID, receiverID, currUserEmail , timestamp, message);

    //construct chatroom ID for the two users
    List<String> ids = [currUserID,receiverID];
    ids.sort(); //ensures that two people chatting with eachother have the same chatroom ID
    String chatroomID = ids.join('_');

    //add to collection in firestore
    await _firestore.collection("chat_rooms").doc(chatroomID).collection("messages").add(newMessage.toMap());

  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID){
    
    //construct chatroom ID for the two users
    List<String> ids = [userID,otherUserID];
    ids.sort(); //ensures that two people chatting with eachother have the same chatroom ID
    String chatroomID = ids.join('_');

    return _firestore.collection("chat_rooms").doc(chatroomID).collection("messages").orderBy("timestamp", descending: false).snapshots(  );
  }

}


// code to get username of current user
    // final userDoc = await FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(currUserID)
    //     .get();
    // final String? currUserUName = userDoc.data()?['username'];
