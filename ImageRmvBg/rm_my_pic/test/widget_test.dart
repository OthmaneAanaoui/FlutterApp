import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}






class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter DemMo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  multipartProdecudre() async {
   

    //for multipartrequest
    var request = http.MultipartRequest('POST', Uri.parse('https://api.remove.bg/v1.0/removebg'));

    //for token
    request.headers.addAll({"Authorization": "Bearer token"});

    //for image and videos and files

    request.files.add(await http.MultipartFile.fromPath("KKQNxfqxhPh9nKGENBynjFAp", "/Users/aanaouiothmane/Desktop/Icons/minion.jpg"));

    //for completeing the request
    var response =await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);


     if (response.statusCode==200) {
        print("SUCCESS");
        print(responseData);
      }
     else {
      print("ERROR");
    }
  }
  late String _base64="";
  createAlbum() async {
      
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
        _base64 = Base64Encoder().convert(response.bodyBytes);
         print(_base64);
        /*setState(() {
          _base64 = Base64Encoder().convert(response.bodyBytes);
        });*/
      }
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Create Data Example'),
        ),
        body: new Center(
        child: new RaisedButton(
          onPressed: () => {
            createAlbum()
          },
          child: new Text('Button Clicks'),
        ),
      ),
      ),
    );
  }
}

   
