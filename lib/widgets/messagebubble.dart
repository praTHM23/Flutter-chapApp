import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message, this.userId, this.isMe);

  final String message;
  final bool isMe;
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color:
                isMe ? Colors.lightGreen[200] : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12)),
          ),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            children: [
              FutureBuilder(
                  future: Firestore.instance
                      .collection('users')
                      .document(userId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('waiting..');
                    }
                    return Text(
                      snapshot.data['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
              Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
