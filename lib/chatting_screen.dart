import 'dart:io';

import 'package:chatting_app_intern/Utils/chat_bubble.dart';
import 'package:chatting_app_intern/firebase/authentication.dart';
import 'package:chatting_app_intern/firebase/database.dart';
import 'package:chatting_app_intern/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

String msg = "";

class chattingScreen extends StatefulWidget {
  chattingScreen({Key? key, required this.name}) : super(key: key);
  final String name;
  File? imgFile;
  @override
  State<chattingScreen> createState() => _chattingScreenState();
}

List<String> msgList = [];
final ImagePicker _picker = ImagePicker();

class _chattingScreenState extends State<chattingScreen> {
  @override
  void initState() {
    getMessages();
  }

  void getMessages() async {
    List<String> data = await readData(widget.name);
    setState(() {
      msgList = data;
    });
  }

  @override
  void dispose() {
    setState(() {
      msgList.clear();
    });
  }

  TextEditingController msgController = TextEditingController();

  Future<File?> selectImage() async {
    try {
      final XFile? selectedImg =
          await _picker.pickImage(source: ImageSource.gallery);
      if (selectedImg == null) {
        return null;
      }
      return File(selectedImg.path);
    } on PlatformException catch (error) {
      print("Some error occured");
    }
    return null;
  }

  Widget messageSentBottomBar() {
    return Row(
      children: [
        Expanded(
          child: IconButton(
              onPressed: () async {
                File? img = await selectImage();
                await Share.shareFiles([img!.path]);
                setState(() {
                  msg = "@An Image is shared in other social Media Platform";
                  msgList.add(msg);
                  msgController.clear();
                  widget.imgFile = img;
                });
                addMessage(widget.name, msg);
              },
              icon: Icon(
                Icons.photo,
                size: 24,
              )),
          flex: 1,
        ),
        Expanded(
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your message..'),
              onChanged: (val) {
                setState(() {
                  msg = val;
                });
              },
              style: TextStyle(fontSize: 15),
            ),
            flex: 5),
        Expanded(
          child: IconButton(
              onPressed: () {
                if (msg.length == 0) return;
                setState(() {
                  msgList.add(msg);
                  msgController.clear();
                });
                addMessage(widget.name, msg);
              },
              icon: Icon(Icons.send)),
          flex: 1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Chatting App"),
          backgroundColor: Colors.brown,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // UPPER SCREEN
              Expanded(
                flex: 12,
                child: ListView.builder(
                  itemBuilder: (contex, index) {
                    return ChatBubble(
                      text: msgList[index],
                      showImage: msgList[index][0]=='@' && index == msgList.length-1,
                      img: widget.imgFile,
                    );
                  },
                  itemCount: msgList.length,
                ),
              ),
              // Lower Screen (Message sent)
              Expanded(flex: 1, child: messageSentBottomBar()),
            ],
          ),
        ));
  }
}
