import 'package:dllylas/Config/property.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// import 'message_model.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  void _sendMessage({String? text, String? imagePath}) {
    if (text != null || imagePath != null) {
      setState(() {
        _messages.insert(
            0,
            Message(
              text: text,
              imagePath: imagePath,
              isSentByMe: true,
              timestamp: DateTime.now(),
            ));
        _controller.clear();
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage(imagePath: pickedFile.path);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: mainColorGrey,
              backgroundImage: AssetImage("assets/images/App-Icon.png"),
              radius: 16,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Customer Support'),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessage(message);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.image_outlined, color: Colors.blue),
            onPressed: _pickImage,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Type a message',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: () => _sendMessage(text: _controller.text),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    final alignment =
        message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = message.isSentByMe ? Colors.blue[100] : Colors.grey[300];
    final textColor = message.isSentByMe ? Colors.black : Colors.black87;
    final radius = message.isSentByMe
        ? BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          )
        : BorderRadius.only(
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Row(
            mainAxisAlignment: message.isSentByMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!message.isSentByMe)
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage("assets/images/App-Icon.png"),
                  radius: 16,
                ),
              if (!message.isSentByMe) SizedBox(width: 8),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (message.imagePath != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imagePath: message.imagePath!),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: radius,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.text != null)
                          Text(
                            message.text!,
                            style: TextStyle(color: textColor),
                          ),
                        if (message.imagePath != null) ...[
                          if (message.text != null) SizedBox(height: 5),
                          Image.file(
                            File(message.imagePath!),
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ],
                        SizedBox(height: 5),
                        Text(
                          DateFormat('h:mm a').format(message.timestamp),
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (message.isSentByMe) SizedBox(width: 8),
              if (message.isSentByMe)
                CircleAvatar(
                  backgroundColor: mainColorGrey,
                  backgroundImage: NetworkImage(
                      "https://dllylas.app/storage/profile/Man.png"),
                  radius: 16,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  FullScreenImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String? text;
  final String? imagePath;
  final bool isSentByMe;
  final DateTime timestamp;

  Message(
      {this.text,
      this.imagePath,
      required this.isSentByMe,
      required this.timestamp});
}
