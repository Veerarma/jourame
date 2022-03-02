import 'package:flutter/material.dart';
import 'package:jourame/screen/create.dart';
import 'package:jourame/screen/display.dart';
import 'package:jourame/screen/home.dart';
import 'package:jourame/screen/profile.dart';
import 'package:jourame/screen/splash.dart';



void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Splash(),
      routes:{
        '/home' :(context) => const Home(),
        '/2':(context)=>const Profile(),
        '/1':(context)=>const Create(),
        '/show':(context)=> const Show()
      }
    );
  }
}



