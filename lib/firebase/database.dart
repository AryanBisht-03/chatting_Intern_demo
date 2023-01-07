import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();

void addMessage(String name, String msg) {
  databaseReference.child(name).push().set({
    'msg': msg,
  });
}

Future<List<String>> readData(String name) async {
  List<String> msg = [];
  final snapshot = await databaseReference.child(name).get();
  for(var snap in snapshot.children){
    final map = snap.value as Map<dynamic, dynamic>;
    msg.add(map['msg']);
  }
  return msg;
}

