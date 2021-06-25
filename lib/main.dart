import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tes/CandiDaerah.dart';
import 'package:flutter_tes/CandiNonKeagamaan.dart';
import 'package:flutter_tes/CandiWanua.dart';
import 'package:flutter_tes/CandiDaerah.dart';
import 'package:flutter_tes/Daerah.dart';
import 'package:flutter_tes/Tab/SideBar.dart';
import 'package:flutter_tes/splashscreen_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tes/Peta.dart';
import 'package:flutter_tes/CandiKerajaan.dart';
import 'package:flutter_tes/CandiPribadi.dart';
import 'package:flutter_tes/Info.dart';
import 'package:flutter_tes/About.dart';
import 'package:flutter_tes/detailPage.dart';
import 'package:flutter_tes/model.dart';
import 'package:flutter_tes/gambar.dart';
import 'CandiBuddha.dart';
import 'CandiHindu.dart';
import 'CandiSiwaBuddha.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (ctx) => SplashScreenPage(),
        'CandiNonKeagamaan': (context) => CandiNonKeagamaan(),
        'CandiWanua': (context) => CandiWanua(),
        //  'CandiDaerah': (context) => CandiDaerah(),
        'CandiKerajaan': (context) => CandiKerajaan(),
        'CandiPribadi': (context) => CandiPribadi(),
        'About': (context) => About(),
        'Info': (context) => Info(),
        'Peta': (context) => Peta(),
        //  'UserViewModel' : (context) => UserViewModel(),
        'MyApp': (context) => MyApp(),
        'Cari': (context) => Cari(),
      },
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  //controller utk tab bar
  //TabController controller;
  int index = 0;
  List<Tripleset> jokes = [];

  List<Widget> list = [
    CandiNonKeagamaan(),
    CandiKerajaan(),
    CandiPribadi(),
    CandiWanua(),
    // CandiDaerah(),
    Peta(),
    // UserViewModel(),
    MyApp(),
    Cari(),
  ];
  @override
  void initState() {
    // controller = new TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INDOCANDI'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => new Search()));
              })
        ],
        backgroundColor: Colors.blueGrey.shade700,
      ),
      drawer: SideBar(),
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
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
                      "assets/images/CandiAbang.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),

                  ListTile(
                      title: Text(
                        "Candi Hindu",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiHindu()));
                        },
                      )),

                  // hindu

                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/borobudur.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Candi Buddha",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiBuddha()));
                        },
                      )),

                  //budha

                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/CandiBarong.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Candi Siwa Buddha",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiSiwaBuddha()));
                        },
                      )),

                  // siwa budha
                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/CandiAngin.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Candi Non Keagamaan",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiNonKeagamaan()));
                        },
                      )),
                  //nonkeagaamn

                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/CandiKelir.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Candi Kerajaan",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiKerajaan()));
                        },
                      )),
                  //kerajaan
                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/CandiBajangRatu.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Candi Pribadi",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiPribadi()));
                        },
                      )),
                  //pribadi
                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/CandiCungkup.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Candi Wanua Watak",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiWanua()));
                        },
                      )),
                  //wanua watak
                  new ClipRRect(
                    child: new Image.asset(
                      "assets/images/CandiGunungKawi.jpg" ??
                          'https://via.placeholder.com/400x200',
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: new Radius.circular(16.0),
                      topRight: new Radius.circular(16.0),
                    ),
                  ),
                  ListTile(
                      title: Text(
                        "Berdasarkan Daerah",
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: new IconButton(
                        icon: new Icon(FontAwesomeIcons.angleRight),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new CandiDaerah()));
                        },
                      )),
                ],
              ),
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => new DetailPage(data: this.data)));
              // },
            ),
          ),
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _Search createState() => _Search();
}

class _Search extends State<Search> {
  List<Tripleset> jokes = [];
  List<Tripleset> _search = [];
  var loading = false;

  Future<List<Tripleset>> mainSearch() async {
    var payload = Uri.encodeComponent("prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>" +
        "   prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>" +
        "prefix : <http://alunalun.info/ontology/candi#>" +
        "prefix schema: <http://schema.org/>" +
        "PREFIX dbo: <http://dbpedia.org/ontology/>" +
        "SELECT ?id ?candi" +
        "(coalesce(group_concat(distinct ?arcas; separator ='\\n'), '') as ?arca)" +
        "(coalesce(group_concat(distinct ?idasall; separator ='\\n'), '') as ?idasal)" +
        "(coalesce(group_concat(distinct ?lokasii; separator ='\\n'), '') as ?lokasi)" +
        "(coalesce(group_concat(distinct ?acara; separator ='\\n'), '') as ?upacara)" +
        "(coalesce(group_concat(distinct ?bahann; separator ='\\n'), '') as ?bahan)" +
        "(coalesce(group_concat(distinct ?gmbr; separator ='\\n'), '') as ?gambar)" +
        "(coalesce(group_concat(distinct ?gmbr1; separator ='\\n'), '') as ?gambar1)" +
        "(coalesce(group_concat(distinct ?gmbr2; separator ='\\n'), '') as ?gambar2)" +
        "(coalesce(group_concat(distinct ?terdiridarii; separator ='\\n'), '-') as ?terdiridari)" +
        "(coalesce(group_concat(distinct ?bagiann; separator ='\\n'), '-') as ?bagiandari)" +
        "(coalesce(group_concat(distinct ?mapp; separator ='\\n'), '') as ?map)" +
        "(coalesce(group_concat(distinct ?relieff; separator ='\\n'), '') as ?relief)" +
        "(coalesce(group_concat(distinct ?sb; separator ='\\n'), '') as ?struktur_bangunan)" +
        "(coalesce(group_concat(distinct ?nama; separator ='\\n'), '') as ?namaLain)" +
        "(coalesce(group_concat(distinct ?desc; separator ='\\n'), '') as ?deskripsi)" +
        "(coalesce(group_concat(distinct ?jeniss; separator ='\\n'), '') as ?jenis)" +
        "(coalesce(group_concat(distinct ?dataa; separator ='\\n'), '') as ?data)" +
        "(coalesce(group_concat(distinct ?sumberr; separator ='\\n'), '') as ?sumber)" +
        "WHERE {" +
        "?id rdf:type	?idtype." +
        "?idtype rdfs:label	?jeniss." +
        "?id :sumberDB	?dataa." +
        " ?id rdfs:label ?candi." +
        "OPTIONAL{?id :Deskripsi ?desc.}" +
        "?id :berasalDari ?idasall." +
        "?idasall dbo:location ?lokasii." +
        "OPTIONAL{?id :untukUpacara ?id." +
        "?idu rdfs:label ?acara}" +
        "OPTIONAL {?id :namaLainDari ?ida." +
        "?ida rdfs:label ?nama}" +
        "OPTIONAL {?id :terdapatRelief ?idrelief." +
        "?idrelief rdfs:label ?relieff}" +
        "OPTIONAL {?id :terdiriDari ?idsb." +
        "?idsb rdfs:label ?sb}" +
        "OPTIONAL {?id :Gambar1 ?gmbr}" +
        "OPTIONAL {?id :Gambar2 ?gmbr1}" +
        "OPTIONAL {?id :Gambar3 ?gmbr2}" +
        "OPTIONAL {?id :map ?mapp.}" +
        "OPTIONAL {?id :terdapatCandi ?idterdiri." +
        "?idterdiri rdfs:label ?terdiridarii}" +
        "OPTIONAL {?id :bagian_dari ?idbagian." +
        "?idbagian rdfs:label ?bagiann}" +
        "OPTIONAL {?id :tersusunDari ?idbahan." +
        "?idbahan rdfs:label ?bahann.}" +
        "OPTIONAL {?id :Sumber ?sumberr.}" +
        "OPTIONAL{?id :terdapatArca ?idarca. ?idarca rdfs:label ?arcas}}" +
        "GROUP BY  ?id ?candi ");

    var headers = new Map<String, String>();
    headers['Content-Type'] = 'application/x-www-form-urlencoded';
    headers['Accept'] = 'application/json';

    var response = await http.post(
        'https://app.alunalun.info/fuseki/candimobile/query',
        headers: headers,
        body: "query=${payload}");
    //print(response.body);

    if (response.statusCode == 200) {
      Map value = json.decode(response.body);
      // print(value);
      var head = SparqlResult.fromJson(value);
      for (var data in head.results.listTriples) {
        // print(data);
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
            data.data,
            data.sumber);
        //print(data);
        jokes.add(tp);
      }
      // print("joek");
      //  print(jokes);
      return jokes;
    } else {}
  }

  TextEditingController controller = new TextEditingController();

  onSearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    jokes.forEach((f) {
      if (f.candi.value.toLowerCase().contains(text) ||
          f.candi.value.toUpperCase().contains(text) ||
          f.id.value.toString().contains(text)) _search.add(f);
      // print("f");
      print(f);
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
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              color: Colors.blueGrey.shade700,
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
                              if (b.gambar.value != '') {
                                return Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new ListTile(
                                            leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                              //"https://candi.alunalun.info/img/CandiGebang1.fb759f20.jpg",
                                              b.gambar.value,
                                            )),
                                            title: Text(b.candi.value),
                                            trailing: new IconButton(
                                              icon: new Icon(
                                                  FontAwesomeIcons.angleRight),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            new DetailPage(
                                                              candi:
                                                                  b.candi.value,
                                                              jenis:
                                                                  b.jenis.value,
                                                              lokasi: b
                                                                  .lokasi.value,
                                                              deskripsi: b
                                                                  .deskripsi
                                                                  .value,
                                                              arca:
                                                                  b.arca.value,
                                                              upacara: b.upacara
                                                                  .value,
                                                              terdiridari: b
                                                                  .terdiridari
                                                                  .value,
                                                              bagiandari: b
                                                                  .bagiandari
                                                                  .value,
                                                              relief: b
                                                                  .relief.value,
                                                              sturktur_bangunan:
                                                                  b.struktur_bangunan
                                                                      .value,
                                                              bahan:
                                                                  b.bahan.value,
                                                              namaLain: b
                                                                  .namaLain
                                                                  .value,
                                                              map: b.map.value,
                                                              gambar: b
                                                                  .gambar.value,
                                                              gambar1: b.gambar1
                                                                  .value,
                                                              gambar2: b.gambar2
                                                                  .value,
                                                              data:
                                                                  b.data.value,
                                                              sumber: b
                                                                  .sumber.value,
                                                            )));
                                              },
                                            )),
                                      ],
                                    ));
                              } else {
                                return Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new ListTile(
                                            leading: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                              "https://candi.alunalun.info/img/CandiGebang1.fb759f20.jpg",
                                            )),
                                            title: Text(b.candi.value),
                                            trailing: new IconButton(
                                              icon: new Icon(
                                                  FontAwesomeIcons.angleRight),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            new DetailPage(
                                                              candi:
                                                                  b.candi.value,
                                                              jenis:
                                                                  b.jenis.value,
                                                              lokasi: b
                                                                  .lokasi.value,
                                                              deskripsi: b
                                                                  .deskripsi
                                                                  .value,
                                                              arca:
                                                                  b.arca.value,
                                                              upacara: b.upacara
                                                                  .value,
                                                              relief: b
                                                                  .relief.value,
                                                              sturktur_bangunan:
                                                                  b.struktur_bangunan
                                                                      .value,
                                                              bahan:
                                                                  b.bahan.value,
                                                              namaLain: b
                                                                  .namaLain
                                                                  .value,
                                                              map: b.map.value,
                                                              gambar:
                                                                  "https://i.pinimg.com/564x/d1/d8/e5/d1d8e5990a1d4b43ee791be68451d4f7.jpg",
                                                              gambar1:
                                                                  "http://sharingdisini.com/wp-content/uploads/2012/10/Candi-Budha.png",
                                                              gambar2:
                                                                  "https://i.pinimg.com/564x/41/d6/3b/41d63ba3378b5b142fd893f2a7952e4d.jpg",
                                                              terdiridari: b
                                                                  .terdiridari
                                                                  .value,
                                                              bagiandari: b
                                                                  .bagiandari
                                                                  .value,
                                                              data:
                                                                  b.data.value,
                                                              sumber: b
                                                                  .sumber.value,
                                                            )));
                                              },
                                            )),
                                      ],
                                    ));
                              }
                              // print("gambar");
                              // print(b.gambar.value);
                              // print(b.candi.value);
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
                                      new ListTile(
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                            a.gambar.value,
                                          )),
                                          title: Text(a.candi.value),
                                          trailing: new IconButton(
                                            icon: new Icon(
                                                FontAwesomeIcons.angleRight),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          new DetailPage(
                                                            candi:
                                                                a.candi.value,
                                                            jenis:
                                                                a.jenis.value,
                                                            lokasi:
                                                                a.lokasi.value,
                                                            deskripsi: a
                                                                .deskripsi
                                                                .value,
                                                            arca: a.arca.value,
                                                            upacara:
                                                                a.upacara.value,
                                                            relief:
                                                                a.relief.value,
                                                            sturktur_bangunan: a
                                                                .struktur_bangunan
                                                                .value,
                                                            bahan:
                                                                a.bahan.value,
                                                            namaLain: a
                                                                .namaLain.value,
                                                            map: a.map.value,
                                                            gambar:
                                                                "https://i.pinimg.com/564x/d1/d8/e5/d1d8e5990a1d4b43ee791be68451d4f7.jpg",
                                                            gambar1:
                                                                "http://sharingdisini.com/wp-content/uploads/2012/10/Candi-Budha.png",
                                                            gambar2:
                                                                "https://i.pinimg.com/564x/41/d6/3b/41d63ba3378b5b142fd893f2a7952e4d.jpg",
                                                            data: a.data.value,
                                                          )));
                                            },
                                          )),
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
