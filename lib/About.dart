import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tes/CandiDaerah.dart';
import 'package:flutter_tes/splashscreen_view.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter_tes/list_item.dart';
import 'package:flutter_tes/Tab/SideBar.dart';

class About extends StatefulWidget {
  @override
  _about createState() => _about();

}

class _about extends State<About> with SingleTickerProviderStateMixin{
  //controller utk tab bar
  TabController controller;


  @override
  void initState(){
    controller = new TabController(vsync: this, length: 4);
    super.initState();

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("WELCOME",
              style: new TextStyle(
                  fontSize: 24.0, fontWeight: FontWeight.bold,

              ),
             ),
            // leading:IconButton(icon: Icon(
            //     Icons.arrow_back
            // ),
            //     onPressed: (){
            //     moveToLastScreen();
            //     }
            //     ),

            backgroundColor: Colors.blueGrey.shade700,
            centerTitle: true,



          ),

          body:Container(
            child: new Center(
              child: new Column(
                  children: <Widget>[
                    // new RichText(
                    //   text: TextSpan(
                    //       style: TextStyle(color: Colors.black, fontSize: 30),
                    //       children: <TextSpan>[
                    //         //TextSpan(text: " Color", style: TextStyle(color: Colors.blue)),
                    //         TextSpan(text: "Welcome!", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800, letterSpacing: 1.0,height: 1.7 ))
                    //       ]
                    //   ),
                    // ),
                      new Image.asset(
                      "assets/images/logo.png",
                          width: 200.0,
                          height: 200.0,
                      ),
                    new RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          children: <TextSpan>[
                            //TextSpan(text: " Color", style: TextStyle(color: Colors.blue)),
                            TextSpan(text: " Proyek bernama alun-alun merupakan proyek penelitianyang didanai oleh Dana Pribadi (2019), RISTEKDIKTI tahun 2018 dan LPPM UKDW tahun 2019. Penelitian ini fokus pada pengembangan model untuk beberapa objek budaya Indonesia, antara lain: Batik, Rumah, Candi, Makanan Tradisional, Upacara, Pakaian, dan Sastra. ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, letterSpacing: 1.0,height: 1.7 ))
                          ]
                      ),
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ]

              )


            )


          )


        );

  }
 // void moveToLastScreen(){
 //    Navigator.pop(context);
 // }

}


