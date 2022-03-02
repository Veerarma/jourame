import 'package:flutter/material.dart';
import 'package:jourame/db/database_provider.dart';
import 'package:jourame/model/j_model.dart';

class Show extends StatelessWidget {
  const Show({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JModel note = ModalRoute.of(context).settings.arguments as JModel;
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Entry"),
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.delete),
            onPressed:(){
              DatabaseProvider.db.deleteNote(note.id);
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              note.title,
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold),
            ),
            // ignore: prefer_const_constructors
            SizedBox(height: 16),
            Text(
              note.body,
              // ignore: prefer_const_constructors
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
