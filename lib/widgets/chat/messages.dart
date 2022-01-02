import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting ||
                  futureSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data.documents as List;

              var userId = chatDocs.isNotEmpty
                  ? chatDocs.first['userId'] as String
                  : null;
              final messageGroups = [];
              final group = [];

              for (var i = 0; i < chatDocs.length; i++) {
                final chat = chatDocs[i];

                if (chat['userId'] != userId) {
                  messageGroups.add(group);
                  group.clear();
                  group.add(chat);
                  userId = chat['userId'];
                } else {
                  group.add(chat);
                }
              }

              messageGroups.add(group);

              return ListView.builder(
                reverse: true,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs[index]['text'],
                  chatDocs[index]['username'],
                  chatDocs[index]['userImage'],
                  chatDocs[index]['userId'] == futureSnapshot.data.uid,
                  key: ValueKey(chatDocs[index].documentID),
                ),
                itemCount: chatDocs.length,
              );
            });
      },
    );
  }
}
