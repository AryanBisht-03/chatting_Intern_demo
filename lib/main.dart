import 'package:chatting_app_intern/Utils/constant.dart';
import 'package:chatting_app_intern/Utils/loadingScreen.dart';
import 'package:chatting_app_intern/chatting_screen.dart';
import 'package:chatting_app_intern/firebase/authentication.dart';
import 'package:chatting_app_intern/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: loginScreen()));
}

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String email = "", phoneNumber = "", age = "", gender = "", gstNumber = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: loading ? loadingScreen() : Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.brown[100],
                appBar: AppBar(
                  backgroundColor: Colors.brown[400],
                  elevation: 0.0,
                  title: Text("Chatting App"),
                ),
                body: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "AGE"),
                          validator: (val) => val!.isEmpty
                              ? "Please enter a valid number"
                              : null,
                          onChanged: (val) {
                            setState(() => age = val);
                          },
                          style: TextStyle(fontSize: 14),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Name"),
                          validator: (val) =>
                              val!.isEmpty ? "Enter your name" : null,
                          onChanged: (val) {
                            setState(() => gender = val);
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(40,0, 40, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[300]
                            ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await signup();
                                  if(result!=null){
                                    print("Sign up secussfull");
                                  }
                                  else
                                    print("some problem");
                                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => userInfoScreen()));
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.mail),
                                  Text("Login with Gmail")
                                ],
                              )),
                        )
                      ]),
                    )
                )
        )
    );
  }
}
