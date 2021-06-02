import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tes/model.dart';

import 'package:flutter_tes/detailPage.dart';

void main() {
  runApp(MaterialApp(
    home: HalamanUtama(),
    debugShowCheckedModeBanner: false,
  ));
}

class HalamanUtama extends StatefulWidget {
  final String map;

  HalamanUtama(
      {Key key, @required this.map})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState(map);
}

class _HomeState extends State<HalamanUtama> {
String map;
_HomeState(this.map);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  WebView( initialUrl: Uri.dataFromString('<html><body><iframe src=map></iframe></body></html>').toString(),
             javascriptMode: JavascriptMode.unrestricted,
          // )
    ),
    );
  }
}

