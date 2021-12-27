import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Platform.isAndroid
                ? TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message...'),
                    onChanged: (value) {
                      setState(() {
                        _enteredMessage = value.trim();
                      });
                    },
                  )
                : Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 5),
                    child: CupertinoTextField(
                      controller: _controller,
                      placeholder: 'Send a message...',
                      onChanged: (value) {
                        setState(() {
                          _enteredMessage = value.trim();
                        });
                      },
                    ),
                  ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 5),
            child: IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.send),
              onPressed: _enteredMessage.isEmpty ? null : _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
