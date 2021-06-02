import 'package:flutter/material.dart';
import 'package:flutter_tes/main.dart';
import 'dart:async';
import 'package:flutter_tes/splashscreen_view.dart';

// class splachscreen
class SplashScreenPage extends StatefulWidget{
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>{
  @override
  void initState(){
    super.initState();
    startSplashScreen();
  }
  startSplashScreen() async{
    var duration = const Duration(seconds:  3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_){
          return MyApp();
        }),
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:Image.asset(
          "assets/images/logo.png",
          width: 200.0,
          height: 100.0,
        )
        // Image.network("https://candi.alunalun.info/img/CandiBajangRatu1.a502e96e.jpg"),
      ),
    );
  }

}