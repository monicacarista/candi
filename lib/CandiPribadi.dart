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

class CandiPribadi extends StatefulWidget {
  @override
  _CandiPribadi createState() => _CandiPribadi();
}

class _CandiPribadi extends State {
  List<Tripleset> jokes = [];

  Future<List<Tripleset>> mainPribadi() async {
    var payload = Uri.encodeComponent(
        "prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>"+
            "   prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>"+
            "prefix : <http://alunalun.info/ontology/candi#>"+
            "prefix schema: <http://schema.org/>"+
            "PREFIX dbo: <http://dbpedia.org/ontology/>"+
            "SELECT ?id ?candi"+
            "(coalesce(group_concat(distinct ?arcas; separator ='\\n'), '') as ?arca)"+
            "(coalesce(group_concat(distinct ?idasall; separator ='\\n'), '') as ?idasal)"+
            "(coalesce(group_concat(distinct ?lokasii; separator ='\\n'), '') as ?lokasi)"+
            "(coalesce(group_concat(distinct ?acara; separator ='\\n'), '') as ?upacara)"+
            "(coalesce(group_concat(distinct ?bahann; separator ='\\n'), '') as ?bahan)"+
            "(coalesce(group_concat(distinct ?gmbr; separator ='\\n'), '') as ?gambar)"+
            "(coalesce(group_concat(distinct ?gmbr1; separator ='\\n'), '') as ?gambar1)"+
            "(coalesce(group_concat(distinct ?gmbr2; separator ='\\n'), '') as ?gambar2)"+
            "(coalesce(group_concat(distinct ?mapp; separator ='\\n'), '') as ?map)"+
            "(coalesce(group_concat(distinct ?relieff; separator ='\\n'), '') as ?relief)"+
            "(coalesce(group_concat(distinct ?sb; separator ='\\n'), '') as ?struktur_bangunan)"+
            "(coalesce(group_concat(distinct ?nama; separator ='\\n'), '') as ?namaLain)"+
            "(coalesce(group_concat(distinct ?desc; separator ='\\n'), '') as ?deskripsi)"+
            "(coalesce(group_concat(distinct ?jeniss; separator ='\\n'), '') as ?jenis)"+
            "(coalesce(group_concat(distinct ?dataa; separator ='\\n'), '') as ?data)"+
            "WHERE {"+
            " ?id rdf:type :CandiPribadi ."+
            "   :CandiPribadi rdfs:label ?jeniss."+
            "?id :sumberDB	?dataa."+
            " ?id rdfs:label ?candi."+
            "OPTIONAL{?id :Deskripsi ?desc.}"+
            "?id :berasalDari ?idasall."+
            "?idasall dbo:location ?lokasii."+
            "OPTIONAL{?id :untukUpacara ?id."+
            "?idu rdfs:label ?acara}"+
            "OPTIONAL {?id :namaLainDari ?ida."+
            "?ida rdfs:label ?nama}"+
            "OPTIONAL {?id :terdapatRelief ?idrelief."+
            "?idrelief rdfs:label ?relieff}"+
            "OPTIONAL {?id :terdiriDari ?idsb."+
            "?idsb rdfs:label ?sb}"+
            "OPTIONAL {?id :Gambar1 ?gmbr}"+
            "OPTIONAL {?id :Gambar2 ?gmbr1}"+
            "OPTIONAL {?id :Gambar3 ?gmbr2}"+
            "OPTIONAL {?id :map ?mapp.}"+
            "OPTIONAL {?id :tersusunDari ?idbahan."+
            "?idbahan rdfs:label ?bahann.}"+
            "OPTIONAL{?id :terdapatArca ?idarca. ?idarca rdfs:label ?arcas}}"+
            "GROUP BY  ?id ?candi ");

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
            data.gambar1,
            data.gambar2,
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
    mainPribadi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candi Pribadi'),
        backgroundColor: Colors.blueGrey.shade700,
      ),
      body: Center(
        child: FutureBuilder<List<Tripleset>>(
          future: mainPribadi(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              print("DAta null");
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
                                                  builder: (context) => new DetailPage(
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
                                                      gambar1 : snapshot.data[index].gambar1.value,
                                                      gambar2: snapshot.data[index].gambar2.value,
                                                      jenis: snapshot
                                                          .data[index]
                                                          .jenis
                                                          .value,
                                                      deskripsi: snapshot
                                                          .data[index]
                                                          .deskripsi
                                                          .value,
                                                      arca: snapshot.data[index]
                                                          .arca.value,
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
                                                      map: snapshot.data[index]
                                                          .map.value,
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
                                child: new Image.network(
                                    "https://i.pinimg.com/564x/d1/d8/e5/d1d8e5990a1d4b43ee791be68451d4f7.jpg"
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
                                              // if (snapshot.data[index].gambar
                                              //     .value !=
                                              //     "") {
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
                                                      gambar:
                                                      "https://i.pinimg.com/564x/d1/d8/e5/d1d8e5990a1d4b43ee791be68451d4f7.jpg",
                                                      gambar1:
                                                      "http://sharingdisini.com/wp-content/uploads/2012/10/Candi-Budha.png",
                                                      gambar2:
                                                      "https://i.pinimg.com/564x/41/d6/3b/41d63ba3378b5b142fd893f2a7952e4d.jpg",
                                                      jenis: snapshot
                                                          .data[index]
                                                          .jenis
                                                          .value,
                                                      deskripsi: snapshot
                                                          .data[index]
                                                          .deskripsi
                                                          .value,
                                                      arca: snapshot.data[index]
                                                          .arca.value,
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
                                                      map: snapshot.data[index]
                                                          .map.value,
                                                      data: snapshot.data[index]
                                                          .data.value)));
                                              //}
                                              // else
                                              // {
                                              //   Navigator.of(context).push(MaterialPageRoute(
                                              //       builder: (context) => new DetailPage(
                                              //           candi: snapshot
                                              //               .data[index]
                                              //               .candi
                                              //               .value,
                                              //           lokasi: snapshot
                                              //               .data[index]
                                              //               .lokasi
                                              //               .value,
                                              //           gambar: snapshot.data[0]
                                              //               .gambar.value,
                                              //           jenis: snapshot
                                              //               .data[index]
                                              //               .jenis
                                              //               .value,
                                              //           deskripsi: snapshot
                                              //               .data[index]
                                              //               .deskripsi
                                              //               .value,
                                              //           arca: snapshot
                                              //               .data[index]
                                              //               .arca
                                              //               .value,
                                              //           upacara: snapshot
                                              //               .data[index]
                                              //               .upacara
                                              //               .value,
                                              //           relief: snapshot
                                              //               .data[index]
                                              //               .relief
                                              //               .value,
                                              //           sturktur_bangunan: snapshot
                                              //               .data[index]
                                              //               .struktur_bangunan
                                              //               .value,
                                              //           bahan: snapshot
                                              //               .data[index]
                                              //               .bahan
                                              //               .value,
                                              //           namaLain: snapshot.data[index].namaLain.value,
                                              //           map: snapshot.data[index].map.value)));
                                              //}
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
