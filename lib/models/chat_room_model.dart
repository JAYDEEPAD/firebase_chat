
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  String? chatroomid;
  String? title;
  Map<String, dynamic>? participants;
  String? lastMessage;
  List<dynamic>? users;
  String? createdon;
  Timestamp? createdAt;

  ChatRoomModel({
    this.chatroomid,
    this.title,
    this.participants,
    this.lastMessage,
    this.users,
    this.createdon,
    this.createdAt
  });

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map['chatroomid'];
    title = map['title'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
    users = map['users'];
    createdAt = map['createdAt'];
    createdon = map['createdon'].toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'chatroomid': chatroomid,
      'participants': participants,
      'lastMessage': lastMessage,
      'users': users,
      'title': title,
      'createdon': createdon,
      'createdAt': createdAt,
    };
  }
}
