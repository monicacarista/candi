import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tes/halamanutama.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class DetailPage extends StatefulWidget {
  final String candi;

  final String lokasi;
  final String gambar;
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
  String candi;

  String lokasi;
  String gambar;

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
        // appBar: AppBar(
        //   title: Text('Candi Non Keagamaan'),
        //   backgroundColor: Colors.blueGrey.shade700,
        //
        // ),
        body: Center(
      child: Center(
        // child: new SingleChildScrollView (

        child: CustomScrollView(
          slivers: <Widget>[
            new SliverAppBar(
              expandedHeight: 200.0,
              snap: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    )),
                background: Image.network(
                  gambar ?? 'https://via.placeholder.com/400x200',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new SliverFillRemaining(
              child: new Padding(
                padding: new EdgeInsets.all(30.0),
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
                              builder: (context) => new HalamanUtama(
                                    map: namaLain,
                                  )));
                        }),
                    new SizedBox(height: 15.0),
                    new Row(
                      children: <Widget>[
                        new Text("Nama Lain :"),
                        new Text(namaLain),
                      ],
                    ),
                    new SizedBox(height: 15.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Asal :"),
                        new Text(lokasi),
                      ],
                    ),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Jenis :"),
                        new Text(jenis),
                      ],
                    ),
                    //   new Divider(),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Arca :"),
                        new Text(arca),
                      ],
                    ),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Relief :"),
                        new Text(relief),
                      ],
                    ),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Strukur Bangunan :"),
                        new Text(sturktur_bangunan),
                      ],
                    ),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Bahan Bangunan :"),
                        new Text(bahan),
                      ],
                    ),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Upacara :"),
                        new Text(upacara),
                      ],
                    ),
                    new SizedBox(height: 12.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Deskripsi :"),
                        new RichText(
                          text: TextSpan(
                            text: deskripsi,
                            //   style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                      ],
                    ),
                    new SizedBox(height: 20.0),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("map :"),
                        new Text(namaLain),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("Sumber :", style: TextStyle(fontSize: 10.0),textAlign: TextAlign.right,),
                        new Text(data, style: TextStyle(fontSize: 10.0),textAlign: TextAlign.right,),
                      ],
                    ),
                    // new Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: <Widget>[
                    //     new IconButton(
                    //       icon: new Icon(FontAwesomeIcons.mapMarkedAlt),
                    //       // onPressed: () {
                    //       //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => new WebPage(data: widget.data)));
                    //       // },
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
        //   }
        // },
        // ),
      ),
    ));
  }
}
