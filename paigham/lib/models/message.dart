import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String receiverID;
  final String senderEmail;

  final String message;

  final Timestamp timestamp;

  Message(this.senderID, this.receiverID, this.senderEmail,this.timestamp, this.message);

  Map<String, dynamic> toMap(){
    return{
      'senderID': senderID,
      'senderEmail' : senderEmail,
      'receiverID': receiverID,
      'message': message, 
      'timestamp': timestamp,
    };
  }
}