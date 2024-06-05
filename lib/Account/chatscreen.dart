import 'package:dllylas/Config/property.dart';

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
  bool issue = false;

  final _formKey = GlobalKey<FormState>();

  String _phoneNumber = '';
  String _name = '';
  String _issueType = 'Select Bug';
  String _language = 'Select Language';
  String _description = '';
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
        body: Visibility(
          visible: issue,
          replacement: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        Text("Customer Support Form",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: mainColorBlack,
                              fontFamily: mainFontbold,
                            )),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Text(
                            "Enter your account information to complete your account",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                            )),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey, // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey
                                    .withOpacity(0.5), // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Customize error border color
                                width: 1.0, // Customize error border width
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Customize focused error border color
                                width:
                                    1.0, // Customize focused error border width
                              ),
                            ),
                            labelText: "Full Name",
                            labelStyle: TextStyle(
                                color: mainColorGrey.withOpacity(0.8),
                                fontSize: 20,
                                fontFamily: mainFontbold),
                            hintText: "Add your Name",
                            hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text('(+964) 07')),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey, // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey
                                    .withOpacity(0.5), // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Customize error border color
                                width: 1.0, // Customize error border width
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Customize focused error border color
                                width:
                                    1.0, // Customize focused error border width
                              ),
                            ),
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(
                                color: mainColorGrey.withOpacity(0.8),
                                fontSize: 20,
                                fontFamily: mainFontbold),
                            hintText: "-- --- ----",
                            hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 9) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            //  _phoneNumber = value!;
                          },
                        ),
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        DropdownButtonFormField<String>(
                          value: _issueType,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey, // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey
                                    .withOpacity(0.5), // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Customize error border color
                                width: 1.0, // Customize error border width
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Customize focused error border color
                                width:
                                    1.0, // Customize focused error border width
                              ),
                            ),
                            labelText: "Issue Bug",
                            labelStyle: TextStyle(
                                color: mainColorGrey.withOpacity(0.8),
                                fontSize: 20,
                                fontFamily: mainFontbold),
                            hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (value) {
                            if (value == "Select Bug") {
                              return 'Please Select Bug';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _issueType = value!;
                            });
                          },
                          onChanged: (String? newValue) {
                            setState(() {
                              _issueType = newValue!;
                            });
                          },
                          items: <String>[
                            'Select Bug',
                            'Bug',
                            'Feature Request',
                            'Other'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontSize: 14,
                                    fontFamily: mainFontnormal),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        DropdownButtonFormField<String>(
                          value: _language,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey, // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey
                                    .withOpacity(0.5), // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Customize error border color
                                width: 1.0, // Customize error border width
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Customize focused error border color
                                width:
                                    1.0, // Customize focused error border width
                              ),
                            ),
                            labelText: "Language",
                            labelStyle: TextStyle(
                                color: mainColorGrey.withOpacity(0.8),
                                fontSize: 20,
                                fontFamily: mainFontbold),
                            hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          validator: (value) {
                            if (value == 'Select Language') {
                              return 'Please Select Language';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _language = value!;
                            });
                          },
                          onChanged: (String? newValue) {
                            setState(() {
                              _language = newValue!;
                            });
                          },
                          items: <String>[
                            'Select Language',
                            'Kurdish',
                            'English',
                            'Arabic',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: mainColorBlack,
                                    fontSize: 14,
                                    fontFamily: mainFontnormal),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey, // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: mainColorGrey
                                    .withOpacity(0.5), // Customize border color
                                width: 1.0, // Customize border width
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color:
                                    Colors.red, // Customize error border color
                                width: 1.0, // Customize error border width
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Customize focused error border color
                                width:
                                    1.0, // Customize focused error border width
                              ),
                            ),
                            labelText: "Short Description",
                            labelStyle: TextStyle(
                                color: mainColorGrey.withOpacity(0.8),
                                fontSize: 20,
                                fontFamily: mainFontbold),
                            hintText: "Add  Description",
                            hintStyle: TextStyle(
                                color: mainColorBlack.withOpacity(0.5),
                                fontSize: 14,
                                fontFamily: mainFontnormal),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                          maxLines: 3,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Description';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _description = value!;
                          },
                        ),
                        SizedBox(
                          height: getHeight(context, 4),
                        ),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                            }
                          },
                          style: TextButton.styleFrom(
                            fixedSize: Size(
                                getWidth(context, 100), getHeight(context, 5)),
                          ),
                          child: Text(
                            "Send",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          child: Column(
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
        ));
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
