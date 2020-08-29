import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(primarySwatch: Colors.teal),
  home: LocalJson(),
));

class LocalJson extends StatefulWidget {
  @override
  LocalJsonState createState() => LocalJsonState();
}

class LocalJsonState extends State<LocalJson> {
  List list = [];
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Json"),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("load/person.json"),
              builder: (context, snap) {
                var data = jsonDecode(snap.data.toString());
                return ListView.builder(
                  itemCount: data == null ? 0 : data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("Ad :" + data[i]["name"]),
                            Text("Yaş :" + data[i]["age"]),
                            Text("Boy :" + data[i]["height"]),
                            Text("Cinsiyet :" + data[i]["gender"]),
                            Text("Saç Rengi :" + data[i]["hair_color"])
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
