import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tes/model.dart';

import 'package:flutter_tes/detailPage.dart';

void main() {
  runApp(MaterialApp(
    home: Cari(),
    debugShowCheckedModeBanner: false,
  ));
}

class Cari extends StatefulWidget {
  @override
  _Cari createState() => _Cari();
}

class _Cari extends State<Cari> {
  List<Tripleset> jokes = [];
  List<Tripleset> _search = [];
  var loading = false;
  // Future<Null> fetchData() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   _list.clear();
  //   final response =
  //   await http.get("https://jsonplaceholder.typicode.com/posts");
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       for (Map i in data) {
  //         _list.add(Posts.formJson(i));
  //         loading = false;
  //       }
  //     });
  //   }
  // }

  Future<List<Tripleset>> mainSearch() async {
    var payload = Uri.encodeComponent(
      "  prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>"+
        "prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>"+
        "prefix : <http://alunalun.info/ontology/candi#>"+
        "prefix schema: <http://schema.org/>"+
       " PREFIX dbo: <http://dbpedia.org/ontology/>"+
      "  SELECT  ?id ?candi   ?lokasi"+
     "   (GROUP_CONCAT(COALESCE(?arcas,''); separator = '' )as ?arca)"+
    "(COALESCE(?gmbr,'') as ?gambar)"+
    "(COALESCE (?mapp, '') as ?map)"+
    "(GROUP_CONCAT(COALESCE(?acara,''); separator = '' )as ?upacara)"+
    "(GROUP_CONCAT(COALESCE(?jeniss,''); separator = '' )as ?jenis)"+
    "(GROUP_CONCAT(COALESCE(?relieff,''); separator = '' )as ?relief)"+
    "(GROUP_CONCAT(COALESCE(?sb,''); separator = '' )as ?struktur_bangunan)"+
    "(GROUP_CONCAT(COALESCE(?nama,''); separator = '' )as ?namaLain)"+
    "(GROUP_CONCAT(COALESCE(?bahann,''); separator = '' )as ?bahan)"+
    "(GROUP_CONCAT(COALESCE(?desc,''); separator = '' )as ?deskripsi)"+
    "WHERE {"+
    "?id rdf:type	?idtype."+
    "?idtype rdfs:label	?jeniss."+
    "?id rdfs:label ?candi."+
    "OPTIONAL{?id :berasalDari ?idasal."+
    "?idasal dbo:location ?asall. }"+
    "OPTIONAL{?id :Deskripsi ?desc.}"+
    "?id :berasalDari ?idasal."+
    "?idasal dbo:location ?lokasi."+
    "OPTIONAL{?id :untukUpacara ?idu."+
    "?idu rdfs:label ?acara}"+
    "OPTIONAL {?id :namaLainDari ?ida."+
    "?ida rdfs:label ?nama}"+
    "OPTIONAL {?id :terdapatRelief ?idrelief."+
    "?idrelief rdfs:label ?relieff}"+
    "OPTIONAL {?id :terdiriDari ?idsb."+
    "?idsb rdfs:label ?sb}"+
    "OPTIONAL {?id :Gambar1 ?gmbr}"+
    "OPTIONAL {?id :map ?mapp.}"+
    "OPTIONAL {?id :tersusunDari ?idbahan."+
    "?idbahan rdfs:label ?bahann.}"+
    "OPTIONAL{?id :terdapatArca ?idarca. ?idarca rdfs:label ?arcas}}"+
    "GROUP BY  ?id ?candi    ?lokasi ?gmbr ?mapp");


    var headers = new Map<String, String>();
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['Accept'] = 'application/json';

    var response = await http.post(
        'https://app.alunalun.info/fuseki/candi/query',
        headers: headers,
        body: "query=${payload}");
    print(response.body);


    if (response.statusCode == 200) {
      Map value = json.decode(response.body);
      // print(value);
      var head = SparqlResult.fromJson(value);
      for (var data in head.results.listTriples) {
        print(data);
        Tripleset tp = Tripleset(data.id,data.idasal,data.candi,data.lokasi,data.gambar,data.jenis,data.deskripsi,data.arca,data.upacara,data.relief,data.struktur_bangunan,data.bahan,data.namaLain,data.map,data.data);
        //print(data);
        jokes.add(tp);
      }
      // print(jokes);
      return jokes;
    }else{

    }

  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    jokes.forEach((f) {
      if (f.candi.value.toLowerCase().contains(text) || f.candi.value.toUpperCase().contains(text)||f.id.value.toString().contains(text))
        _search.add(f);
    });

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.blue,
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: TextField(
                    controller: controller,
                    onChanged: onSearch,
                    decoration: InputDecoration(
                        hintText: "Search", border: InputBorder.none),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSearch('');
                    },
                    icon: Icon(Icons.cancel),
                  ),
                ),
              ),
            ),
            loading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Expanded(
              child: _search.length != 0 || controller.text.isNotEmpty
                  ? ListView.builder(
                itemCount: _search.length,
                itemBuilder: (context, index) {
                  final b = _search[index];
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            b.candi.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),

                          new IconButton(
                            icon: new Icon(FontAwesomeIcons.angleRight),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => new DetailPage(

                                candi: b.jenis.value,
                                jenis: b.jenis.value,
                                lokasi : b.lokasi.value,
                                deskripsi: b.deskripsi.value,
                                arca: b.arca.value,
                                upacara: b.upacara.value,
                                relief: b.relief.value,
                                sturktur_bangunan: b.struktur_bangunan.value,
                                bahan: b.bahan.value,
                                namaLain:b.namaLain.value,
                                map: b.map.value,
                              )));
                            },
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(b.jenis.value),

                        ],
                      ));
                },
              )
                  : ListView.builder(
                itemCount: jokes.length,
                itemBuilder: (context, i) {
                  final a = jokes[i];
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            a.candi.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(a.jenis.value),
                        ],
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

