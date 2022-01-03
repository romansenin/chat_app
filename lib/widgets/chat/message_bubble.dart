import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.username, this.userImage, this.isMe,
      {this.isFirst = false, this.key});

  final Key key;
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Theme.of(context).accentColor : Colors.grey[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isMe
                          ? Theme.of(context).accentTextTheme.headline1.color
                          : Colors.black,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe
                          ? Theme.of(context).accentTextTheme.headline1.color
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (isFirst)
          Positioned(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage:
                  userImage != null ? NetworkImage(userImage) : null,
            ),
            top: 0,
            left: !isMe ? 120 : null,
            right: isMe ? 120 : null,
          ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
