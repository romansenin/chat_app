import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     Firestore.instance
      //         .collection('chats/TVslzyO2GcSGp6TBLVHE/messages')
      //         .add({'text': 'This was added by clicking the button!'});
      //   },
      // ),
    );
  }
}
