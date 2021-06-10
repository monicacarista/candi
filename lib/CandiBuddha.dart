import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tes/detailPage.dart';
import 'package:flutter_tes/model.dart';
import 'package:flutter_tes/Tab/SideBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'list_item.dart';

class CandiBuddha extends StatefulWidget {
  @override
  _CandiBuddha createState() => _CandiBuddha();
}

class _CandiBuddha extends State {
  List<Tripleset> jokes = [];

  Future<List<Tripleset>> mainBuddha() async {
    var payload = Uri.encodeComponent(
        "prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>" +
            "  prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>" +
            "prefix : <http://alunalun.info/ontology/candi#>" +
            "prefix schema: <http://schema.org/>" +
            "PREFIX dbo: <http://dbpedia.org/ontology/>" +
            "SELECT  ?id ?idasal ?candi  ?jenis  ?lokasi ?data" +
            "(GROUP_CONCAT(COALESCE(?arcas,''); separator = '' )as ?arca)" +
            "(COALESCE(?gmbr,'') as ?gambar)" +
            "(COALESCE (?mapp, '') as ?map)" +
            "  (GROUP_CONCAT(COALESCE(?acara,''); separator = '' )as ?upacara)" +
            "(GROUP_CONCAT(COALESCE(?relieff,''); separator = '' )as ?relief)" +
            "(GROUP_CONCAT(COALESCE(?sb,''); separator = '' )as ?struktur_bangunan)" +
            "(GROUP_CONCAT(COALESCE(?nama,''); separator = '' )as ?namaLain)" +
            " (GROUP_CONCAT(COALESCE(?bahann,''); separator = '' )as ?bahan)" +
            "(GROUP_CONCAT(COALESCE(?desc,''); separator = '' )as ?deskripsi)" +
            "  WHERE {" +
            " ?id rdf:type :CandiBuddha ." +
            "   :CandiBuddha rdfs:label ?jenis." +
            "?id :sumberDB	?data."+
            "   ?id rdfs:label ?candi." +

            "OPTIONAL{?id :Deskripsi ?desc.}" +
            "?id :berasalDari ?idasal." +
            "?idasal dbo:location ?lokasi. " +
            " OPTIONAL{?id :untukUpacara ?idu." +
            "  ?idu rdfs:label ?acara}" +
            "  OPTIONAL {?id :namaLainDari ?ida." +
            "?ida rdfs:label ?nama}" +
            "OPTIONAL {?id :terdapatRelief ?idrelief." +
            "?idrelief rdfs:label ?relieff}" +
            "OPTIONAL {?id :terdiriDari ?idsb." +
            "?idsb rdfs:label ?sb}" +
            "OPTIONAL {?id :Gambar1 ?gmbr}" +
            "OPTIONAL {?id :map ?mapp.}" +
            "OPTIONAL {?id :tersusunDari ?idbahan." +
            "?idbahan rdfs:label ?bahann.}" +
            "  OPTIONAL{?id :terdapatArca ?idarca. ?idarca rdfs:label ?arcas}}" +
            "GROUP BY  ?id ?idasal ?candi  ?jenis   ?lokasi ?gmbr ?mapp ?data");

    var headers = new Map<String, String>();
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['Accept'] = 'application/json';

    var response = await http.post(
        'https://app.alunalun.info/fuseki/candimobile/query',
        headers: headers,
        body: "query=${payload}");
    print(response.body);

    if (response.statusCode == 200) {
      Map value = json.decode(response.body);
      print(value);
      var head = SparqlResult.fromJson(value);
      for (var data in head.results.listTriples) {
        print(data);
        Tripleset tp = Tripleset(
            data.id,
            data.idasal,
            data.candi,
            data.lokasi,
            data.gambar,
            data.jenis,
            data.deskripsi,
            data.arca,
            data.upacara,
            data.relief,
            data.struktur_bangunan,
            data.bahan,
            data.namaLain,
            data.map,data.data);
        //print(data);
        jokes.add(tp);
      }
      print(jokes);
      return jokes;
    } else {}
  }

//var gam = "https://asset.kompas.com/crops/YZGoSq4D-3SOvY6X4ie7lWA5RwY=/0x0:700x467/750x500/data/photo/2021/04/08/606eb2725991f.jpg";
  @override
  void initState() {
    super.initState();
    mainBuddha();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candi Buddha'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: Center(
        child: FutureBuilder<List<Tripleset>>(
          future: mainBuddha(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              print("Data null");
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (snapshot.data[index].gambar.value != "") {
                      return new Card(
                        elevation: 2.0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(16.0),
                        ),
                        child: new InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new ClipRRect(
                                child: new Image.network(
                                  // "assets/images/borobudur.jpg",
                                  snapshot.data[index].gambar.value ??
                                      'https://via.placeholder.com/400x200',
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: new Radius.circular(16.0),
                                  topRight: new Radius.circular(16.0),
                                ),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.all(16.0),
                                  child: new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new ListTile(
                                          title: Text(
                                            snapshot.data[index].candi.value,
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: new IconButton(
                                            icon: new Icon(
                                                FontAwesomeIcons.angleRight),
                                            onPressed: () {
                                              Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) =>
                                                  new DetailPage(
                                                      candi: snapshot
                                                          .data[index]
                                                          .candi
                                                          .value,
                                                      lokasi: snapshot
                                                          .data[index]
                                                          .lokasi
                                                          .value,
                                                      gambar: snapshot
                                                          .data[index]
                                                          .gambar
                                                          .value,
                                                      jenis: snapshot
                                                          .data[index]
                                                          .jenis
                                                          .value,
                                                      deskripsi: snapshot
                                                          .data[index]
                                                          .deskripsi
                                                          .value,
                                                      arca: snapshot
                                                          .data[index]
                                                          .arca
                                                          .value,
                                                      upacara: snapshot
                                                          .data[index]
                                                          .upacara
                                                          .value,
                                                      relief: snapshot
                                                          .data[index]
                                                          .relief
                                                          .value,
                                                      sturktur_bangunan: snapshot
                                                          .data[index]
                                                          .struktur_bangunan
                                                          .value,
                                                      bahan: snapshot
                                                          .data[index]
                                                          .bahan
                                                          .value,
                                                      namaLain: snapshot
                                                          .data[index]
                                                          .namaLain
                                                          .value,
                                                      map: snapshot
                                                          .data[index]
                                                          .map
                                                          .value,
                                                      data: snapshot.data[index].data.value)));
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: new EdgeInsets.all(13.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Text(snapshot
                                                  .data[index].jenis.value),
                                              new Text(snapshot
                                                  .data[index].lokasi.value),
                                            ],
                                          ),
                                        )
                                      ])),
                            ],
                          ),

                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => new DetailPage(data: this.data)));
                          // },
                        ),
                      );
                      return Text("ada");
                    } else {
                      return new Card(
                        elevation: 2.0,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(16.0),
                        ),
                        child: new InkWell(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new ClipRRect(
                                child: new Image.asset(
                                  "assets/images/main.jpg",
                                  //snapshot.data[index].gambar.value ?? 'https://via.placeholder.com/400x200',
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: new Radius.circular(16.0),
                                  topRight: new Radius.circular(16.0),
                                ),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.all(16.0),
                                  child: new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new ListTile(
                                          title: Text(
                                            snapshot.data[index].candi.value,
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: new IconButton(
                                            icon: new Icon(
                                                FontAwesomeIcons.angleRight),
                                            onPressed: () {
                                              if (snapshot.data[index].gambar
                                                  .value !=
                                                  "") {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) =>
                                                    new DetailPage(
                                                        candi: snapshot
                                                            .data[index]
                                                            .candi
                                                            .value,
                                                        lokasi: snapshot
                                                            .data[index]
                                                            .lokasi
                                                            .value,
                                                        gambar: snapshot
                                                            .data[index]
                                                            .gambar
                                                            .value,
                                                        jenis: snapshot
                                                            .data[index]
                                                            .jenis
                                                            .value,
                                                        deskripsi: snapshot
                                                            .data[index]
                                                            .deskripsi
                                                            .value,
                                                        arca: snapshot
                                                            .data[index]
                                                            .arca
                                                            .value,
                                                        upacara: snapshot
                                                            .data[index]
                                                            .upacara
                                                            .value,
                                                        relief: snapshot
                                                            .data[index]
                                                            .relief
                                                            .value,
                                                        sturktur_bangunan:
                                                        snapshot
                                                            .data[index]
                                                            .struktur_bangunan
                                                            .value,
                                                        bahan: snapshot
                                                            .data[index]
                                                            .bahan
                                                            .value,
                                                        namaLain: snapshot
                                                            .data[index]
                                                            .namaLain
                                                            .value,
                                                        map: snapshot.data[index].map.value)));
                                              } else {
                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => new DetailPage(
                                                        candi: snapshot
                                                            .data[index]
                                                            .candi
                                                            .value,
                                                        lokasi: snapshot
                                                            .data[index]
                                                            .lokasi
                                                            .value,
                                                        gambar: snapshot.data[0]
                                                            .gambar.value,
                                                        jenis: snapshot
                                                            .data[index]
                                                            .jenis
                                                            .value,
                                                        deskripsi: snapshot
                                                            .data[index]
                                                            .deskripsi
                                                            .value,
                                                        arca: snapshot
                                                            .data[index]
                                                            .arca
                                                            .value,
                                                        upacara: snapshot
                                                            .data[index]
                                                            .upacara
                                                            .value,
                                                        relief: snapshot
                                                            .data[index]
                                                            .relief
                                                            .value,
                                                        sturktur_bangunan: snapshot
                                                            .data[index]
                                                            .struktur_bangunan
                                                            .value,
                                                        bahan: snapshot
                                                            .data[index]
                                                            .bahan
                                                            .value,
                                                        namaLain: snapshot.data[index].namaLain.value,
                                                        map: snapshot.data[index].map.value)));
                                              }
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: new EdgeInsets.all(13.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              new Text(snapshot
                                                  .data[index].jenis.value),
                                              new Text(snapshot
                                                  .data[index].lokasi.value),
                                            ],
                                          ),
                                        )
                                      ])),
                            ],
                          ),

                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => new DetailPage(data: this.data)));
                          // },
                        ),
                      );
                    }
                  });
            }
          },
        ),
      ),
    );
  }
}
