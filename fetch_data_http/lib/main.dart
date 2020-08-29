import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: FetchData(),
    ));

class FetchData extends StatefulWidget {
  @override
  FetchDataState createState() => FetchDataState();
}

class FetchDataState extends State<FetchData> {
  var url = "http://swapi.dev/api/people/";
  List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJsonData();
  }

  Future<http.Response> getJsonData() async {
    var response = await http
        .get(url, headers: {HttpHeaders.contentTypeHeader: "application/json"});
    print(response.body);
    setState(() {
      var convertData = jsonDecode(response.body);
      data = convertData["results"];
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("HTTP GET"),
        ),
        body: FutureBuilder<http.Response>(
          future: getJsonData(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              child: Column(
                                children: [
                                  Container(
                                    child: Text(data[index]["name"]),
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                Container(
                                    child: Text(data[index]["gender"]),
                                    padding: EdgeInsets.all(10.0),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }
        ));
  }
}
