import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/landing/splash_screen.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/chatmodel/chatmodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';
// import 'message_model.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool issue = false;

  final _formKey = GlobalKey<FormState>();
  void updateChat() {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    if (productrovider.chats.isNotEmpty) {
      Network(false).getData("chatupdate/${userdata["phone"]}").then((value) {
        if (value != "") {
          if (value["code"] == "200") {
            setState(() {
              productrovider.setChats((value['chats'] as List)
                  .map((x) => Chatmodel.fromMap(x))
                  .toList());
              loading = false;
            });
          }
        }
      });
    } else {
      _timer?.cancel();
    }
  }

  String _phoneNumber = '';
  String _name = '';
  String _issueType = 'Select Bug';
  String _language = 'Select Language';
  String _description = '';
  bool loading = false;
  int issueId = 0;
  void _sendMessage({String? text, XFile? imagePath}) {
    setState(() {
      loading = true;
    });
    if (text != null) {
      var data = {
        "issue_id": issueId,
        "msg": text,
        "type": "text",
        "customer_phone": userdata["phone"],
      };

      Network(false).postData("sendChat", data, context).then((value) {
        print(value);
        if (value != "") {
          if (value["code"] == "201") {
            updateChat();
          } else {
            setState(() {
              loading = false;
            });
          }
        } else {
          setState(() {
            loading = false;
          });
        }
      });
      setState(() {
        _controller.clear();
      });
    } else {
      Map<String, String> body = {
        "issue_id": issueId.toString(),
        "type": "image",
        "customer_phone": userdata["phone"],
      };
      Network(false).addImage("sendChat", body, imagePath!.path).then((value) {
        print(value);
        if (value != "") {
          if (value["code"] == "201") {
            updateChat();
          } else {
            setState(() {
              loading = false;
            });
          }
        } else {
          setState(() {
            loading = false;
          });
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _sendMessage(imagePath: pickedFile);
    }
  }

  @override
  void initState() {
    updateChat();
    _startTimer();
    super.initState();
  }

  Timer? _timer;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      updateChat();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
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
          visible: productrovider.chats.isNotEmpty,
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
                  itemCount: productrovider.chats.length,
                  itemBuilder: (context, index) {
                    final message = productrovider.chats[index];
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
            icon: loading
                ? Container(
                    height: 30, width: 30, child: CircularProgressIndicator())
                : Icon(Icons.send, color: Colors.blue),
            onPressed: () => _sendMessage(text: _controller.text),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Chatmodel message) {
    issueId = message.issueId!;
    bool isSentByMe = message.adminId == null ? true : false;
    bool isText = message.type == "text" ? true : false;

    final alignment =
        isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    final color = isSentByMe ? Colors.blue[100] : Colors.grey[300];

    final textColor = isSentByMe ? Colors.black : Colors.black87;

    final radius = isSentByMe
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
            mainAxisAlignment:
                isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isSentByMe)
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: AssetImage("assets/images/App-Icon.png"),
                  radius: 16,
                ),
              if (!isSentByMe) SizedBox(width: 8),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    if (!isText) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imagePath: message.content!),
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
                        if (isText)
                          Text(
                            message.content!,
                            style: TextStyle(color: textColor),
                          ),
                        if (!isText) ...[
                          if (message.content != null) SizedBox(height: 5),
                          CachedNetworkImage(
                            imageUrl: dotenv.env['imageUrlServer']! +
                                message.content!,
                            // imageUrl:
                            //     "https://firebasestorage.googleapis.com/v0/b/dllylas-ec27d.appspot.com/o/DLly%20Las%20popo.jpg?alt=media&token=2a5ce41a-d3b6-4eb0-a43c-dff6fae351f6",
                            placeholder: (context, url) =>
                                Image.asset("assets/images/Logo-Type-2.png"),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/Logo-Type-2.png"),
                            filterQuality: FilterQuality.low,

                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          )
                        ],
                        SizedBox(height: 5),
                        Text(
                          timeAgo(message.createdAt!),
                          style: TextStyle(fontSize: 10, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isSentByMe) SizedBox(width: 8),
              if (isSentByMe)
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

  String timeAgo(String datetime) {
    final date2 = DateTime.now();
    DateTime date = DateTime.parse(datetime);
    final difference = date2.difference(date);
    // check text bawar
    if ((difference.inDays / 7).floor() >= 1) {
      return 'Last week'.tr;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays}' + 'days ago'.tr;
    } else if (difference.inDays >= 1) {
      return 'Yesterday'.tr;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours}' + 'hours ago'.tr;
    } else if (difference.inHours >= 1) {
      return '1 hour ago'.tr;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes}' + 'minutes ago'.tr;
    } else if (difference.inMinutes >= 1) {
      return '1 minute ago'.tr;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds}' + 'seconds ago'.tr;
    } else {
      return 'Just now'.tr;
    }
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
                child: CachedNetworkImage(
              imageUrl: dotenv.env['imageUrlServer']! + imagePath,
              // imageUrl:
              //     "https://firebasestorage.googleapis.com/v0/b/dllylas-ec27d.appspot.com/o/DLly%20Las%20popo.jpg?alt=media&token=2a5ce41a-d3b6-4eb0-a43c-dff6fae351f6",
              placeholder: (context, url) =>
                  Image.asset("assets/images/Logo-Type-2.png"),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/Logo-Type-2.png"),
              filterQuality: FilterQuality.low,

              fit: BoxFit.contain,
            )),
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
