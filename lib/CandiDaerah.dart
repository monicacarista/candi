import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tes/Daerah.dart';
import 'package:flutter_tes/detailPage.dart';
import 'package:flutter_tes/Daerah.dart';
import 'package:flutter_tes/model.dart';
import 'package:flutter_tes/Tab/SideBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'list_item.dart';
import 'main.dart';

class CandiDaerah extends StatefulWidget {
  @override
  _CandiDaerah createState() => _CandiDaerah();
}

class _CandiDaerah extends State {
  List<Tripleset> jokes = [];

  Future<List<Tripleset>> mainDaerah() async {
    var payload = Uri.encodeComponent(
        "prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>" +
            "  prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>" +
            " prefix : <http://alunalun.info/ontology/candi#>" +
            " prefix schema: <http://schema.org/>" +
            "  PREFIX dbo: <http://dbpedia.org/ontology/>" +
            "  SELECT DISTINCT ?lokasi (SAMPLE(?idasall)as ?idasal) (SAMPLE(?idx)as ?id) (SAMPLE(?candix) as ?candi)  (SAMPLE(?jenisx)as ?jenis)  (SAMPLE(?datax)as ?data)  " +
            "  (GROUP_CONCAT(COALESCE(?arcas,''); separator = '-' )as ?arca)" +
            " (GROUP_CONCAT(COALESCE(?gmbr,''); separator = '' )as ?gambar)" +
            " (GROUP_CONCAT(COALESCE(?gmbr1,''); separator = '' )as ?gambar1)" +
            " (GROUP_CONCAT(COALESCE(?gmbr2,''); separator = '' )as ?gambar2)" +
            " (GROUP_CONCAT(COALESCE(?mapp,''); separator = '' )as ?map)" +
            " (GROUP_CONCAT(COALESCE(?acara,''); separator = '-' )as ?upacara)" +
            " (GROUP_CONCAT(COALESCE(?relieff,''); separator = '-' )as ?relief)" +
            " (GROUP_CONCAT(COALESCE(?terdiridarii,''); separator = '-' )as ?terdiridari)" +
            " (GROUP_CONCAT(COALESCE(?sumberr,''); separator = '-' )as ?sumber)" +
            " (GROUP_CONCAT(COALESCE(?bagiann,''); separator = '-' )as ?bagiandari)" +
            " (GROUP_CONCAT(COALESCE(?sb,''); separator = '-' )as ?struktur_bangunan)" +
            " (GROUP_CONCAT(COALESCE(?nama,''); separator = '-' )as ?namaLain)" +
            "(GROUP_CONCAT(COALESCE(?bahann,''); separator = '-' )as ?bahan)" +
            "(GROUP_CONCAT(COALESCE(?desc,''); separator = '' )as ?deskripsi)" +
            "  WHERE {" +
            "  ?idx :berasalDari ?idasall." +
            "  ?idasall dbo:location ?lokasi." +
            "     :CandiNonKeagamaan rdfs:label ?jenisx." +
            " ?idx :sumberDB	?datax." +
            " ?idx rdfs:label ?candix." +
            " OPTIONAL{?idx :Deskripsi ?desc.}" +
            "  OPTIONAL{?idx :untukUpacara ?idu." +
            " ?idu rdfs:label ?acara}" +
            "OPTIONAL {?idx :namaLainDari ?ida." +
            "?ida rdfs:label ?nama}" +
            "OPTIONAL {?idx :terdapatCandi ?idterdiri." +
            "?idterdiri rdfs:label ?terdiridarii}" +
            "OPTIONAL {?idx :bagian_dari ?idbagian." +
            "?idbagian rdfs:label ?bagiann}" +
            "OPTIONAL {?idx :terdapatRelief ?idrelief." +
            " ?idrelief rdfs:label ?relieff}" +
            " OPTIONAL {?idx :terdiriDari ?idsb." +
            " ?idsb rdfs:label ?sb}" +
            "OPTIONAL {?idx :Gambar1 ?gmbr}" +
            "OPTIONAL {?idx :Gambar2 ?gmbr1}" +
            "OPTIONAL {?idx :Gambar3 ?gmbr2}" +
            " OPTIONAL {?idx :map ?mapp.}" +
            "OPTIONAL {?idx :tersusunDari ?idbahan." +
            " ?idbahan rdfs:label ?bahann.}" +
            "OPTIONAL {?idx :Sumber ?sumberr.}" +
            "OPTIONAL{?idx :terdapatArca ?idarca. ?idarca rdfs:label ?arcas}}" +
            "GROUP BY  ?lokasi");
    // var payload = Uri.encodeComponent("PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> PREFIX : <http://alunalun.info/ontology/candi#> PREFIX dbo: <http://dbpedia.org/ontology/>"+
    //         "SELECT ?id_daerah ?lokasi ?candi ?jenis ?gmbr ?mapp ?data ?namaLain ?struktur_bangunan ?bahan ?deskripsi ?arca ?upacara ?relief WHERE{"+
    //         "?id_daerah rdf:type	:Provinsi."+
    //         "?id_daerah dbo:location ?lokasi.}");
    var headers = new Map<String, String>();
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['Accept'] = 'application/json';

    var response = await http.post(
        'https://app.alunalun.info/fuseki/candimobile/query',
        headers: headers,
        body: "query=${payload}");
  // print(response.body);

    if (response.statusCode == 200) {
      Map value = json.decode(response.body);
    //  print(value);
      var head = SparqlResult.fromJson(value);
      for (var data in head.results.listTriples) {
     //   print(data);
        Tripleset tp = Tripleset(
            data.id,
            data.idasal,
            data.terdiridari,
            data.bagiandari,
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
            data.map,
            data.data,  data.sumber);
        //print(data);
        jokes.add(tp);
      }
      // print(jokes);
      return jokes;
    } else {}
  }

//var gam = "https://asset.kompas.com/crops/YZGoSq4D-3SOvY6X4ie7lWA5RwY=/0x0:700x467/750x500/data/photo/2021/04/08/606eb2725991f.jpg";
  @override
  void initState() {
    super.initState();
    mainDaerah();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candi Daerah'),
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => new Search()));
              })
        ],
      ),
      drawer: SideBar(),
      body: Center(
        child: FutureBuilder<List<Tripleset>>(
          future: mainDaerah(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              print("DAta null");
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // if (snapshot.data[index].gambar.value != "") {
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
                            // new ClipRRect(
                            //   child: new Image.network(
                            //     // "assets/images/borobudur.jpg",
                            //     snapshot.data[index].gambar.value ??
                            //         'https://via.placeholder.com/400x200',
                            //   ),
                            //   borderRadius: BorderRadius.only(
                            //     topLeft: new Radius.circular(16.0),
                            //     topRight: new Radius.circular(16.0),
                            //   ),
                            // ),
                            new Padding(
                                padding: new EdgeInsets.all(16.0),
                                child: new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new ListTile(
                                        title: Text(
                                          snapshot.data[index].lokasi.value,
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: new IconButton(
                                          icon: new Icon(
                                              FontAwesomeIcons.angleRight),
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        new Daerah(
                                                          idasal: snapshot
                                                              .data[index]
                                                              .lokasi
                                                              .value
                                                              .toString(),
                                                        )));
                                          },
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: new EdgeInsets.all(13.0),
                                      //   child: new Row(
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      //     children: <Widget>[
                                      //       new Text(snapshot
                                      //           .data[index].jenis.value),
                                      //       new Text(snapshot
                                      //           .data[index].lokasi.value),
                                      //     ],
                                      //   ),
                                      // )
                                    ])),
                          ],
                        ),

                        // onTap: () {
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => new DetailPage(data: this.data)));
                        // },
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
