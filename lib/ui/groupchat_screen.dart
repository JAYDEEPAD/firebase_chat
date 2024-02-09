import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ichat/allConstants/constants.dart';
import 'package:ichat/models/chat_room_model.dart';
import 'package:ichat/models/user_model.dart';

class GroupScreen extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const GroupScreen({Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  TextEditingController searchCtr = TextEditingController();
  List<UserModel> selectableUsers = [];
  Set<UserModel> selectedUsers = {};

  Future<ChatRoomModel?> createGroupChat() async {


  }

  @override
  void initState() {
    super.initState();
    fetchSelectableUsers();
  }

  void fetchSelectableUsers() async {
    final snapshot = await FirebaseFirestore.instance.collection("users").get();
    if (snapshot.docs.isNotEmpty) {
      final List<UserModel> users = snapshot.docs
          .map((doc) => UserModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((user) => user.uid != widget.userModel.uid)
          .toList();
      setState(() {
        selectableUsers = users;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("New Group"),
          actions: [
            IconButton(
              onPressed: () {
                createGroupChat();
              },
              icon: Icon(Icons.check),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchCtr,
                        onChanged: (value) {
                          setState(() {});
                        },
                        decoration: InputDecoration(hintText: "Search Members"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                searchCtr.text.isEmpty
                    ? Expanded(
                  child: ListView.builder(
                    itemCount: selectableUsers.length,
                    itemBuilder: (context, index) {
                      final user = selectableUsers[index];
                      final isSelected = selectedUsers.contains(user);

                      return ListTile(
                        onTap: () {
                          setState(() {
                            if (!isSelected) {
                              selectedUsers.add(user);
                            } else {
                              selectedUsers.remove(user);
                            }
                          });
                        },
                        title: Text(user.fullname.toString()),
                        subtitle: Text(user.email.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilepic!),
                        ),
                        trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
                      );
                    },
                  ),
                )
                    : Expanded(
                  child: ListView.builder(
                    itemCount: selectableUsers.length,
                    itemBuilder: (context, index) {
                      final user = selectableUsers[index];
                      final isSelected = selectedUsers.contains(user);

                      return ListTile(
                        onTap: () {
                          setState(() {
                            if (!isSelected) {
                              selectedUsers.add(user);
                            } else {
                              selectedUsers.remove(user);
                            }
                          });
                        },
                        title: Text(user.fullname.toString()),
                        subtitle: Text(user.email.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilepic!),
                        ),
                        trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text("Selected Users:"),
                Expanded(
                  child: ListView.builder(
                    itemCount: selectedUsers.length,
                    itemBuilder: (context, index) {
                      final user = selectedUsers.toList()[index];
                      return ListTile(
                        title: Text(user.fullname.toString()),
                        subtitle: Text(user.email.toString()),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilepic!),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




