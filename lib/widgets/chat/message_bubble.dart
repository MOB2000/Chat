import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String _username;
  final String _userImageUrl;
  final String _message;
  final bool _isMe;
  final Key key;

  MessageBubble(
    this.key,
    this._username,
    this._userImageUrl,
    this._message,
    this._isMe,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
              _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _isMe ? Colors.grey : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !_isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: _isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              width: 140,
              child: Column(
                crossAxisAlignment:
                    _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    _username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                  Text(
                    _message,
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: _isMe
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: _isMe ? null : 120,
          right: _isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              _userImageUrl,
            ),
          ),
        ),
      ],
    );
  }
}
