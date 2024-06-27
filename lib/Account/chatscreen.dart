import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';

import 'package:dllylas/model/chatmodel/chatmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Landing/splash_screen.dart';
import '../main.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool issue = false;

  final _formKey = GlobalKey<FormState>();
  void updateChat(bool check) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    if (productrovider.chats.isNotEmpty || check) {
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

  String _issueType = 'Select Bug';
  String _language = 'Select Language';
  String _description = '';
  bool loading = false;
  int issueId = 0;
  void _sendMessage({String? text, XFile? imagePath}) {
    if (text != null) {
      setState(() {
        loading = true;
      });
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
            updateChat(true);
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
    } else if (imagePath != null) {
      setState(() {
        loading = true;
      });
      Map<String, String> body = {
        "issue_id": issueId.toString(),
        "type": "image",
        "customer_phone": userdata["phone"],
      };
      Network(false).addImage("sendChat", body, imagePath!.path).then((value) {
        print(value);
        if (value != "") {
          if (value["code"] == "201") {
            updateChat(true);
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
    updateChat(false);
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
      updateChat(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child:  Scaffold(
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
                Text('Customer Support'.tr),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            reverseDuration: const Duration(milliseconds: 0),
            switchInCurve: Curves.easeInCubic,
            switchOutCurve: Curves.easeInCubic,
            child: productrovider.chats.isNotEmpty
                ? Column(
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
                  )
                : SingleChildScrollView(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
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
                                    Text("Customer Support Form".tr,
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
                                        "Enter your account information to contact for chat suport".tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: mainColorBlack,
                                          fontFamily: mainFontnormal,
                                        )),
                                    SizedBox(
                                      height: getHeight(context, 1),
                                    ),
                                    DropdownButtonFormField<String>(
                                      value: _issueType,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color:
                                                mainColorGrey, 
                                            width: 1.0, 
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: mainColorGrey.withOpacity(
                                                0.5), 
                                            width: 1.0, 
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, 
                                            width:
                                                1.0, // Customize error border width
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
                                        labelText: "Issue Bug".tr,
                                        labelStyle: TextStyle(
                                            color: mainColorGrey.withOpacity(0.8),
                                            fontSize: 20,
                                            fontFamily: mainFontbold),
                                        hintStyle: TextStyle(
                                            color:
                                                mainColorBlack.withOpacity(0.5),
                                            fontSize: 14,
                                            fontFamily: mainFontnormal),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      validator: (value) {
                                        if (value == "Select Bug") {
                                          return 'Please Select Bug'.tr;
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
                                      // todo: Jare dyar niya ch la xo dagret
                                      items: <String>[
                                        'Select Bug',
                                        'account',
                                        'order',
                                        'delivery',
                                        'other'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value.tr,
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
                                            color:
                                                mainColorGrey, 
                                            width: 1.0, 
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: mainColorGrey.withOpacity(
                                                0.5), 
                                            width: 1.0, 
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, 
                                            width:
                                                1.0, 
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, 
                                            width:
                                                1.0, 
                                          ),
                                        ),
                                        labelText: "Language".tr,
                                        labelStyle: TextStyle(
                                            color: mainColorGrey.withOpacity(0.8),
                                            fontSize: 20,
                                            fontFamily: mainFontbold),
                                        hintStyle: TextStyle(
                                            color:
                                                mainColorBlack.withOpacity(0.5),
                                            fontSize: 14,
                                            fontFamily: mainFontnormal),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      validator: (value) {
                                        if (value == 'Select Language') {
                                          return 'Please Select Language'.tr;
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
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value.tr,
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
                                            color:
                                                mainColorGrey, 
                                            width: 1.0, 
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: mainColorGrey.withOpacity(
                                                0.5), 
                                            width: 1.0, 
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .red, 
                                            width:
                                                1.0, // Customize error border width
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
                                        labelText: "Short Description".tr,
                                        labelStyle: TextStyle(
                                            color: mainColorGrey.withOpacity(0.8),
                                            fontSize: 20,
                                            fontFamily: mainFontbold),
                                        hintText: "Add  Description".tr,
                                        hintStyle: TextStyle(
                                            color:
                                                mainColorBlack.withOpacity(0.5),
                                            fontSize: 14,
                                            fontFamily: mainFontnormal),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                      ),
                                      maxLines: 3,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a Description'.tr;
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
                                          setState(() {
                                            loading = true;
                                          });
                                          var data = {
                                            "customer_phone": userdata["phone"],
                                            "type": _issueType,
                                            "lang": _language,
                                            "msg": _description,
                                          };
                                          Network(false)
                                              .postData(
                                                  "createIssue", data, context)
                                              .then((value) {
                                            print(value);
                                            if (value != "") {
                                              if (value["code"] == "201") {
                                                updateChat(true);
                                                setState(() {});
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
                                      },
                                      style: TextButton.styleFrom(
                                        fixedSize: Size(getWidth(context, 100),
                                            getHeight(context, 5)),
                                      ),
                                      child: Text(
                                        "Start Conversion".tr,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        loading ? waitingWiget(context) : SizedBox(),
                      ],
                    ),
                  ),
          )),
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
                hintText: 'Type a message'.tr,
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
