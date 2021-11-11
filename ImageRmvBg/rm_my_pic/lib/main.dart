import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

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

  
  
   _save() async {

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
         _base64 = Base64Encoder().convert(response.bodyBytes);
          final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.bodyBytes));
          
      }

    }
    
  File? image;
  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(image == null) return;

    final imageTemporary = File(image.path);
    setState(()=>this.image= imageTemporary);

    }
    on PlatformException catch(e){
      print("faild");
    }

  } 
  
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
        backgroundColor: Color.fromRGBO(255, 252, 250,8),
        appBar: new AppBar(
        leading: Icon(Icons.menu),
        title: Text('Remove My BG'),
        actions: [
          Icon(Icons.favorite),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search),
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.purple,
      ),
        body:
        SingleChildScrollView(child: Column
        (
           
          children: <Widget>
          [
            Column(
              
              children: <Widget>[
                _buildImage(),
                
               /* image != null ? Image.file(image!,width:160, height:160,
                fit:BoxFit.cover,) :  FlutterLogo(size:160)*/
                
              ],
            ),
            
            Column(
              
              children: <Widget>[
                const SizedBox(height: 12),
                
               // buildButton(title: 'Choose Image' ,icon: Icons.image_outlined ,onClicked: getImage,),
                

               
                image != null ? buildDownloadButton(title: 'Download' ,icon: Icons.download ,onClicked: _save,) :
                  buildButton(title: 'Choose Image' ,icon: Icons.image_outlined ,onClicked: pickImage,),
                
                
              ],
              ),

              Column(
                
              children: <Widget>[
              
                
               const SizedBox(height: 12),
                
                image != null ? buildAnnuleButton(title: 'Annuler' ,icon: Icons.cancel ,onClicked: _save,) :
                  const SizedBox(height: 12),
                
                
                
              ],
              ),
              
              
          ],
          
        ),)
         
      );
    
  }

Widget buildButton ({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,

    }) => ElevatedButton(

      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(56),
        primary:Colors.white,
        onPrimary:Colors.purple,
        textStyle: TextStyle(fontSize:20),
        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
      ),
      
    child: Row(children: [
      Icon(icon,size:28),
      const SizedBox(width:16),
      Text(title),
    ],),
    onPressed: onClicked,
    );

Widget buildDownloadButton ({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,

    }) => ElevatedButton(

      style: ElevatedButton.styleFrom(
        
        minimumSize: Size.fromHeight(56),
        primary:Colors.purple,
        onPrimary:Colors.white,
        textStyle: TextStyle(fontSize:20),
        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
      ),
      
    child: Row(children: [
      Icon(icon,size:28),
      const SizedBox(width:16),
      Text(title),
    ],),
    onPressed: onClicked,
);

Widget buildAnnuleButton ({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,

    }) => ElevatedButton(

      style: ElevatedButton.styleFrom(
        
        minimumSize: Size.fromHeight(56),
        primary:Colors.red,
        onPrimary:Colors.white,
        textStyle: TextStyle(fontSize:20),
        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0))),
      ),
      
    child: Row(children: [
      Icon(icon,size:28),
      const SizedBox(width:16),
      Text(title),
    ],),
    onPressed: onClicked,
);
 
Widget _buildImage() {
    if (image == null) {
    
      return Container(
        alignment: Alignment.center,
         margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: Colors.purple)),
        
        child: Icon(
          
          Icons.upload,
          
          color: Colors.purple,
          size: 200.0,
          
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      );
    } else {
     
      return
      Container(
        alignment: Alignment.center,
         margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.purple)),
        
       // margin: const EdgeInsets.only(left: 20.0, right: 20.0,top: 20.0),
        child: Image.file(image!,
                fit:BoxFit.cover,)
    
      );
      
    }
       
  }

  
  
}
class MyWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 40.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 40.0);
    

    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            0.0,
            size.width - ((i + 1) * size.width / 8),
            size.height - 160);
      } else {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            size.height - 120,
            size.width - ((i + 1) * size.width / 8),
            size.height - 160);
      }
    }

    path.lineTo(0.0, 40.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


 
