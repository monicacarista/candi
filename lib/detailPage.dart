import 'dart:convert';
import 'dart:ui';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tes/Peta.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class DetailPage extends StatefulWidget {
  final String candi;

  final String lokasi;
  final String gambar;
  final String gambar1;
  final String gambar2;
  final String jenis;
  final String deskripsi;
  final String data;
  final String arca;
  final String upacara;
  final String relief;
  final String sturktur_bangunan;
  final String bahan;
  final String namaLain;
  final String map;
  DetailPage({
    Key key,
    @required this.candi,
    @required this.lokasi,
    @required this.gambar,
    @required this.gambar1,
    @required this.gambar2,
    @required this.jenis,
    @required this.deskripsi,
    @required this.arca,
    @required this.upacara,
    @required this.relief,
    @required this.sturktur_bangunan,
    @required this.bahan,
    @required this.namaLain,
    @required this.map,
    @required this.data,
  }) : super(key: key);

  @override
  _DetailPageState createState() => new _DetailPageState(
      candi,
      lokasi,
      gambar,
      gambar1,
      gambar2,
      jenis,
      deskripsi,
      arca,
      upacara,
      relief,
      sturktur_bangunan,
      bahan,
      namaLain,
      map,
      data);
}

class _DetailPageState extends State<DetailPage> {
  int _current = 0;
  List imgList = [
    'https://candi.alunalun.info/img/CandiApit1.9daf8517.jpg',
    'https://candi.alunalun.info/img/CandiApit1.9daf8517.jpg'
  ];

  String candi;
  String lokasi;
  String gambar;
  String gambar1;
  String gambar2;
  String jenis;
  String deskripsi;
  String arca;
  String upacara;
  String relief;
  String sturktur_bangunan;
  String bahan;
  String namaLain;
  String map;
  String data;
  _DetailPageState(
      this.candi,
      this.lokasi,
      this.gambar,
      this.gambar1,
      this.gambar2,
      this.jenis,
      this.deskripsi,
      this.arca,
      this.upacara,
      this.relief,
      this.sturktur_bangunan,
      this.bahan,
      this.namaLain,
      this.map,
      this.data);

  List<Tripleset> jokes = [];
  // Map value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: new Column(children: <Widget>[
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  images: [
                    NetworkImage(gambar),
                    NetworkImage(gambar1),
                    NetworkImage(gambar2),
                  ],
                  autoplay: false,
                  animationDuration: Duration(milliseconds: 1000),
                  showIndicator: false,
                  dotSize: 5.0,
                  dotSpacing: 15.0,
                  dotColor: Colors.grey,
                  borderRadius: true,
                ),
              ),
            ],
          ),
        ),
        new Column(
          children: <Widget>[
            Padding(
              padding: new EdgeInsets.all(20.0),
              child: new Column(
                children: <Widget>[
                  new Text(
                    candi,
                    style: Theme.of(context).textTheme.title,
                  ),
                  new IconButton(
                      icon: new Icon(FontAwesomeIcons.mapMarkedAlt),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new Peta(
                                  map: map,
                                )));
                      }),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Nama Lain :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Asal :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(lokasi,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 2)))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Jenis :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(
                        jenis,
                        maxLines: 10,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(height: 2),
                      ))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Arca"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(arca,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1.5)))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Relief :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(relief,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1)))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Struktur Bangunan :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(sturktur_bangunan,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1)))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Bahan Bangunan :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(bahan,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1)))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Upacara :"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(upacara, style: TextStyle(height: 1))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("Deskripsi"),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(deskripsi,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1)))
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text(
                        "Sumber :",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          child: Text(data,
                              maxLines: 10,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(height: 1, fontSize: 10)))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ]),
    ));
  }
}
