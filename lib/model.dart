import 'dart:io';
import 'dart:convert';

import 'package:flutter_tes/Tab/SideBar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'list_item.dart';

class SparqlResult {
  final HeaderSparql header;
  final Results results;

  SparqlResult(this.header, this.results);

  factory SparqlResult.fromJson(Map json) {
    var header = new HeaderSparql(List.from(json['head']['vars']));
    var results = new Results(List.from(json["results"]["bindings"]));

    return SparqlResult(header, results);
  }
}

class HeaderSparql {
  List<String> vars;

  HeaderSparql(List<String> json) : this.vars = json;
}

class Results {
  List<Tripleset> listTriples = [];

  Results(List data) {
    this.listTriples = createListTripleset(data);
  }

  List<Tripleset> createListTripleset(List data) {
    List<Tripleset> list = [];
    for (var value in data) {
      Tripleset triple = Tripleset.fromJson(value);
      list.add(triple);
    }
    return list;
  }
}

class Tripleset {
  final TypeValue id;
  final TypeValue idasal;
  final TypeValue candi;
  final TypeValue lokasi;
  final TypeValue gambar;
  final TypeValue gambar1;
  final TypeValue gambar2;
  final TypeValue jenis;
  final TypeValue deskripsi;
  final TypeValue arca;
  final TypeValue upacara;
  final TypeValue relief;
  final TypeValue struktur_bangunan;
  final TypeValue bahan;
  final TypeValue namaLain;
  final TypeValue map;
  final TypeValue data;

  Tripleset(
      this.id,
      this.idasal,
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
      this.struktur_bangunan,
      this.bahan,
      this.namaLain,
      this.map,
      this.data);

  factory Tripleset.fromJson(Map json) {
    return Tripleset(
      TypeValue.fromJson(json['id']),
      TypeValue.fromJson(json['idasal']),
      TypeValue.fromJson(json['candi']),
      TypeValue.fromJson(json['lokasi']),
      TypeValue.fromJson(json['gambar']),
      TypeValue.fromJson(json['gambar1']),
      TypeValue.fromJson(json['gambar2']),
      TypeValue.fromJson(json['jenis']),
      TypeValue.fromJson(json['deskripsi']),
      TypeValue.fromJson(json['arca']),
      TypeValue.fromJson(json['upacara']),
      TypeValue.fromJson(json['relief']),
      TypeValue.fromJson(json['struktur_bangunan']),
      TypeValue.fromJson(json['bahan']),
      TypeValue.fromJson(json['namaLain']),
      TypeValue.fromJson(json['map']),
      TypeValue.fromJson(json['data']),
    );
  }

  String toString() {
    String s =
        "${id}\t\t${candi}\t\t${lokasi}\t\t${gambar}\t\t${jenis}\t\t${deskripsi}\t\t${arca}\t\t${upacara}\t\t${relief}\t\t${struktur_bangunan}\t\t${bahan}\t\t${namaLain}";
    return s;
  }
}

class TypeValue {
  final String type;
  final String value;

  TypeValue(this.type, this.value);

  TypeValue.fromJson(Map json)
      : type = json['type'],
        value = json['value'];

  String toString() {
    String s = "$value";
    return s;
  }
}

//
// class UserViewModel extends StatefulWidget{
//
//   @override
//   _HalamanJsonState createState() => _HalamanJsonState();
// }
//
// class _HalamanJsonState extends State {
//
//   Future<List<Tripleset>> main1() async {
//     var payload = Uri.encodeComponent("prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>"+
//         "prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>"+
//         "prefix : <http://alunalun.info/ontology/candi#> "+
//         "SELECT ?candi WHERE {?id rdf:type :CandiNonKeagamaan.?id rdfs:label ?candi . }");
//     var headers = new Map<String, String>();
//     headers['Content-Type'] = 'application/x-www-form-urlencoded';
//     headers['Accept'] = 'application/json';
//
//     var response = await http.post(
//         'https://app.alunalun.info/fuseki/candi/query',
//         headers: headers,
//         body: "query=${payload}");
//     List<Tripleset> jokes = [];
//
//     if (response.statusCode == 200) {
//       Map value = json.decode(response.body);
//       var head = SparqlResult.fromJson(value);
//       for (var data in head.results.listTriples) {
//         // print(data);
//         Tripleset tp = Tripleset(data.candi,data.lokasi,data.gambar,data.deskripsi,data.asal);
//         jokes.add(tp);
//       }
//       return jokes;
//     }
//
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     main1();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(
//           title: Text('Flutter ListView'),
//         ),
//         body: Center(
//           child: FutureBuilder <List<Tripleset>>(
//             future: main1(),
//             builder: (context, AsyncSnapshot snapshot) {
//             //  print(snapshot.data);
//               if (snapshot.data == null) {
//                 return Container(
//                   child: Center(
//                     child: Text("Loading"),
//                   ),
//                 );
//               } else {
//
//                 return
//                   ListView.builder(
//                      itemCount: snapshot.data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           height: 75,
//                           color: Colors.white,
//                           child: Center(child: Text(snapshot.data[index].candi.value),
//                           ),);
//                       }
//                   );
//               }
//               // By default show a loading spinner.
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//
//     );
//   }
// }
