// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:jourame/db/database_provider.dart';
import 'package:jourame/model/j_model.dart';

class Create extends StatefulWidget {
  const Create({Key key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {


  String title;
  String body;
  DateTime date;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  addNote(JModel note){
    DatabaseProvider.db.addNewNote(note);
    // ignore: avoid_print
    print("ll");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  const Text("date")
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors
          TextField(
            controller: titleController,
            // ignore: prefer_const_constructors
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Title"
            ),
            // ignore: prefer_const_constructors
            style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
          ),
          Expanded(
              // ignore: prefer_const_constructors
              child: TextField(
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: InputBorder.none,
                hintText: "Add.."),))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            title=titleController.text;
            body=bodyController.text;
            date=DateTime.now();
          });
          JModel note = JModel(title: title,body: body,date: date);
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
    );
  }
}
