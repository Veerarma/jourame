// ignore_for_file: void_checks

import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:jourame/db/database_provider.dart';
import 'package:jourame/model/j_model.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   DateTime _dateTime ;

   getNotes(DateTime dateTime) async{
     final notes = await DatabaseProvider.db.getNotes(dateTime);
     return notes;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:  const Text("Welcome"),
      ),
      bottomNavigationBar:  ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.add, title: 'Add'),
          TabItem(icon: Icons.people, title: 'Profile'),
        ],
        initialActiveIndex: 1,//optional, default as 0
        // ignore: sdk_version_set_literal
        onTap: (int i) => Navigator.pushNamed(context, '/$i',arguments: {_dateTime}),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text('Pick a date'),
                onPressed: () {
                  showDatePicker(
                      context: context,
                      initialDate: _dateTime ?? DateTime.now(),
                      firstDate: DateTime(2001),
                      lastDate: DateTime(2040)
                  ).then((date) {
                    setState( () {
                      _dateTime = date;
                      // ignore: avoid_print
                      print(_dateTime);
                    });
                  });
                },
              ),
            ),
            const SizedBox(height: 10,width: 10),
           FutureBuilder(
             future: getNotes(_dateTime),
             // ignore: missing_return
             builder: (context, noteData){
               switch(noteData.connectionState){
                 case ConnectionState.waiting:
                   {
                     // ignore: prefer_const_constructors
                     return Center(child: CircularProgressIndicator());
                   }
                 case ConnectionState.done:
                   {
                     if(noteData.data==Null){
                       // ignore: prefer_const_constructors
                       return Center(child :Text("Create one"));
                     }
                     else{
                       return Padding(padding: const EdgeInsets.all(8.0),
                         child: ListView.builder(
                             shrinkWrap: true,
                             itemCount: noteData.data.length,
                             itemBuilder: (context,index){
                               String title = noteData.data[index]['title'];
                               String body = noteData.data[index]['body'];
                               String date = noteData.data[index]['date'];
                               int id = noteData.data[index]['id'];
                               return Card(
                                 child: ListTile(
                                   title: Text(title),
                                   subtitle: Text(body),
                                   onTap: (){
                                     Navigator.pushNamed(context, '/show',
                                         arguments: JModel(
                                           title: noteData.data[index]['title'],
                                           body: noteData.data[index]['body'],
                                           id :id,
                                           date: DateTime.parse(date),
                                         ));
                                   },
                                 ),
                               );
                             }),
                       );
                     }
                   }
               }
             },
           )
            //ListView.builder(itemBuilder: itemBuilder),
          ],
        ),
      ),
    );
  }
}
