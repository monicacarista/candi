import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tes/CandiDaerah.dart';
import 'package:flutter_tes/splashscreen_view.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:flutter_tes/list_item.dart';
import 'package:flutter_tes/Tab/SideBar.dart';

class Info extends StatefulWidget {
  @override
  _info createState() => _info();

}

class _info extends State<Info> with SingleTickerProviderStateMixin{
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
    return  Scaffold(
            appBar: AppBar(
              title: Text("INDOCANDI",

                style: new TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold,
                  backgroundColor: Colors.blueGrey.shade700,
                ),
              ),
              // leading:IconButton(icon: Icon(
              //     Icons.arrow_back
              // ),
              //     onPressed: (){
              //     moveToLastScreen();
              //     }
              //     ),

              backgroundColor: Colors.blue,
              centerTitle: true,



            ),

            body:Container(
                child: new Center(
                    child: new Column(
                        children: <Widget>[
                          new Image.asset(
                            "assets/images/borobudur.jpg",
                            width: 200.0,
                            height: 200.0,
                          ),
                          new RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 18),
                                children: <TextSpan>[
                                  //TextSpan(text: " Color", style: TextStyle(color: Colors.blue)),
                                  TextSpan(text: " Istilah Candi diduga berasal dari kata “Candika” yang berarti nama salah satu perwujudan Dewi Durga sebagai dewi kematian. Karenanya candi selalu dihubungkan dengan monumen tempat pedharmaan untuk memuliakan raja anumerta (yang sudah meninggal) contohnya candi Kidal untuk memuliakan Raja Anusapati. ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, letterSpacing: 1.0,height: 1.7 ))
                                ]
                            ),
                            textWidthBasis: TextWidthBasis.longestLine,
                          ),
                        ]

                    )


                )


            )


        )
    ;
  }
// void moveToLastScreen(){
//    Navigator.pop(context);
// }

}


