import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageGroup extends StatelessWidget {
  MessageGroup(this.messages, this.currentUserId);

  final List<dynamic> messages;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: messages
          .map(
            (message) => MessageBubble(
              message['text'],
              message['username'],
              message['userImage'],
              message['userId'] == currentUserId,
              key: ValueKey(message.documentID),
            ),
          )
          .toList(),
    );
  }
}
