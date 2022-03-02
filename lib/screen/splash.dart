import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(milliseconds: 3000), () => Navigator.popAndPushNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Opacity(opacity: 0.5,child: Image.asset('asset/img_1.png')),
          Shimmer.fromColors(
            period: const Duration(milliseconds: 2000),
            baseColor: Colors.purpleAccent,
            highlightColor:  const Color(0xFF8D637F),
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Jourame',
                style: TextStyle(
                    fontSize: 60.0,
                    fontFamily: 'Pacifico',
                    shadows: <Shadow> [
                      Shadow(
                          blurRadius: 18.0,
                          color: Colors.black,
                          offset: Offset.fromDirection(120,12)
                      )
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


/*
*/