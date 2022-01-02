import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';

class MessageGroup extends StatelessWidget {
  MessageGroup(this.messages, this.currentUserId);

  final List<dynamic> messages;
  final String currentUserId;

  List<Widget> messagesToBubbles() {
    messages.removeAt(0);

    return messages
        .map(
          (message) => MessageBubble(
            message['text'],
            message['username'],
            message['userImage'],
            message['userId'] == currentUserId,
            key: ValueKey(message.documentID),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(children: [
        MessageBubble(
          messages.first['text'],
          messages.first['username'],
          messages.first['userImage'],
          messages.first['userId'] == currentUserId,
          isFirst: true,
          key: ValueKey(messages.first.documentID),
        ),
        ...messagesToBubbles(),
      ]),
    );
  }
}
