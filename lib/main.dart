import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:examp/Todo.dart';
import 'package:examp/List.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      primaryColor: const Color(0xFF02BB9F),
      primaryColorDark: const Color(0xFF167F67),
      accentColor: const Color(0xFF167F67),
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  List data;
  List<Todo> parseJosn(String response) {
    if(response==null){
      return [];
    }
    final parsed =
    json.decode(response.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Todo>((json) => new Todo.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Load local JSON file",
            style: new TextStyle(color: Colors.white),),
        ),
        body: new Container(
          child: new Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: new FutureBuilder(
                future: DefaultAssetBundle.of(context)
                    .loadString('assets/Technology.json'),
                builder: (context, snapshot) {
                  List<Todo> countries =
                  parseJosn(snapshot.data.toString());
                  return !countries.isEmpty
                      ? new CountyList(jdata: countries)
                      : new Center(child: new CircularProgressIndicator());
                }),
          ),
        ));
  }
}
