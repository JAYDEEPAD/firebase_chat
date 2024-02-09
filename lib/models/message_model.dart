import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  String? createdon;
  Timestamp? createdAt;
  MessageModel({this.messageId,this.sender, this.text, this.seen, this.createdon,this.createdAt});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map['messageId'];
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    createdAt= map['createdAt'];
    createdon = map['createdon'].toString();
  }
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'sender': sender,
      'text': text,
      'seen': seen,
      'createdAt': createdAt,
      'createdon': createdon,
    };
  }
}
