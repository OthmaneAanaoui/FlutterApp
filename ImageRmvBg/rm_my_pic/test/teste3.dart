import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


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

  late File _image;
  
  
  Future getImage() async {
    
      
      http.Response response = await http.post(
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
      headers: <String, String>{
        'X-Api-Key': 'KKQNxfqxhPh9nKGENBynjFAp',
      },
      body: <String, String>{
        'image_url': 'https://wallpaper-house.com/data/out/9/wallpaper2you_366962.jpg',
      },
    );
   
      if (mounted) {
         print(response.body);
        setState(() {
          _base64 = Base64Encoder().convert(response.bodyBytes);
        });
      }
    }


  
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        appBar: new AppBar
        (title: new Text('Flutter Base64 Strings'),
          backgroundColor: Colors.orange,
        ),
        body:Column
        (
          children: <Widget>
          [
            Column(
              children: <Widget>[
                _buildImage(),
                
              ],
            ),
            Column(
              children: <Widget>[
                OutlineButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),side: BorderSide(color: Colors.red)),
                    
                    
                  child:  new Text("Download"),
                  
                  
                    borderSide: const BorderSide(
                color: Colors.blueGrey,
                
                style: BorderStyle.solid,
                width: 1,
              ),
                          onPressed: getImage,)
                
              ],
            ),
            Column(
              children: <Widget>[
                OutlineButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),side: BorderSide(color: Colors.red)),
                    
                    
                  child:  new Text("Choose Imagee"),
                  
                  
                    borderSide: const BorderSide(
                color: Colors.pink,
                
                style: BorderStyle.solid,
                width: 1,
              ),
                          onPressed: getImage,)
                
              ],
              ),
          ],
          
        ), 
      );
    
  }

  
 
Widget _buildImage() {
    if (_base64 == null) {
      return Container(

        child: Icon(
          Icons.add,
          color: Colors.grey,
        ),
      );
    } else {
     
      return
      Container(
        
        margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 20.0),
        child: Image.memory(base64Decode(_base64))
    
      );
      
    }
       
  }
  
}