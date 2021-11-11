import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Base64 String',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State {
  late String _base64="";

  @override
  void initState() {
    super.initState();
    (() async {
      
      http.Response response = await http.post(
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      headers: <String, String>{
        'X-Api-Key': 'KKQNxfqxhPh9nKGENBynjFAp',
      },
      body: jsonEncode(<String, String>{
        'image_url': 'https://wallpaper-house.com/data/out/9/wallpaper2you_366962.jpg',
      }),
    );
   
      if (mounted) {
        setState(() {
          _base64 = Base64Encoder().convert(response.bodyBytes);
        });
      }
    })();
    
  }

  

  @override
  Widget build(BuildContext context) {
    if (_base64 == null||_base64.isEmpty)
      return new Container();
    Uint8List bytes = Base64Codec().decode(_base64);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Base64 Strings'),
        backgroundColor: Colors.orange,),
      body: Container(
          child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                 child: Card(
                     child: Image.memory(bytes,fit: BoxFit.cover,),),
                     
                  
      )),
      
      
      ),


    );
    
  }

  
}