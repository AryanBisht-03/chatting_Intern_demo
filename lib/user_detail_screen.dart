import 'package:chatting_app_intern/chatting_screen.dart';
import 'package:chatting_app_intern/firebase/authentication.dart';
import 'package:chatting_app_intern/main.dart';
import 'package:flutter/material.dart';

class userInfoScreen extends StatefulWidget {
  const userInfoScreen({Key? key}) : super(key: key);

  @override
  State<userInfoScreen> createState() => _userInfoScreenState();
}

List names = ["Aryan", "Ayush", "Abhay", "Swati", "Meena"];

class _userInfoScreenState extends State<userInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatting app"),
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(onPressed: () async{
            await signOut();
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> loginScreen()));
          },

              icon: Icon(Icons.logout)),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //TODO GO TO NEXT SCREEN
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => chattingScreen(name: names[index])));
            },
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  title: Text(names[index]),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.blue[200],
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(10), child: Icon(Icons.person)),
                  ),
                  subtitle: Text("Join the chat"),
                ),
              ),
            ),
          );
        },
        itemCount: names.length,
      ),
    );
  }
}
