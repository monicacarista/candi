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

      body:  WebView(
     //   initialUrl: Uri.dataFromString('<html><body><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d374247.5951971246!2d112.23856168839899!3d-7.755868324447915!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e786dbd3277dd1d%3A0xd1928cb171e27a41!2sCandi%20Bajang%20Ratu!5e1!3m2!1sid!2sid!4v1571645109449!5m2!1sid!2sid"></iframe></body></html>', mimeType: 'text/html').toString(),
        initialUrl: Uri.dataFromString('<html><body><iframe src=$map width="700" height="700"></iframe></body></html>', mimeType: 'text/html').toString(),
        //initialUrl: Uri.dataFromString('<html><body><iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d374247.5951971246!2d112.23856168839899!3d-7.755868324447915!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e786dbd3277dd1d%3A0xd1928cb171e27a41!2sCandi%20Bajang%20Ratu!5e1!3m2!1sid!2sid!4v1571645109449!5m2!1sid!2sid"></iframe></body></html>').toString(),
             javascriptMode: JavascriptMode.unrestricted,
          // )
    ),
    );
  }
}

