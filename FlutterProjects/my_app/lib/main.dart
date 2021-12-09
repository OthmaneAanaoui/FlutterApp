import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'src/locations.dart' as locations;

import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
 Future<List<User>> getData() async {
    var response =
     await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
     var jsonData = jsonDecode(response.body);
    List<User> dataList = [];
    for (var u in jsonData) {
         User data = User(u["name"], u["email"], u["username"]);
         dataList.add(data);
     }
    print(dataList.length);
    return dataList;
   }


   Future<List<Photo>> getPhoto() async {
    var response =
     await http.get(Uri.https('jsonplaceholder.typicode.com', 'photos'));
     var jsonData = jsonDecode(response.body);
    List<Photo> dataList = [];
    for (var u in jsonData) {
         Photo data = Photo(u["id"], u["title"], u["thumbnailUrl"]);
         dataList.add(data);
     }
    print(dataList.length);
    return dataList;
   }


 
void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      
      home: MyStatefulWidget(),
    );
  }
}

class DataFormAPI extends StatefulWidget {
  @override
_DataFormAPIState createState() => _DataFormAPIState();
}

class _DataFormAPIState extends State<DataFormAPI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('user Data')),
      
    );
  }
  
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  
   
  
  
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  final List<Widget> _widgetOptions = <Widget>[
    Column(
      
       children: [
                
         Container(
          height: 450.0,
       child: Card(
         child: FutureBuilder<List<User>>(
        future: getData(),
        
        builder: (context, snapshot) {
            if (snapshot.data == null) {
             return Container(
            child: Text("Loading"),
            );
         }else{ 
            return new ListView.builder(
                   scrollDirection: Axis.vertical,
                  
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      
                        title: Column(
                        children: [
                              Text(snapshot.data![i].name),
                              
                        ],
                      ),
                    );
                 });
             }
          },
       ),
      ),
    ),
              ],
             
    ),
    Column(
      children: <Widget>[
        Text("Events planing", style: optionStyle),
        FlutterLogo(),
        
      ],
    ),
    Column(
      children: <Widget>[
     Expanded(
       
       child: SizedBox(
         
         height: 450.0,
         child: new ListView.builder(
           scrollDirection: Axis.vertical,
           itemCount: 12,
           itemBuilder: (BuildContext ctxt, int index) {
             return new Text("tt");
           },
         ),
       ),
     ),
     new IconButton(
       icon: Icon(Icons.remove_circle),
       onPressed: () {},
     ),
   ],
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    ),
    
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(33.89352, -5.54727);
  final Map<String, Marker> _markers = {};
  /*void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }*/

   Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
        backgroundColor: Color.fromRGBO(255, 252, 250,8),
        appBar: new AppBar(
        leading: Icon(Icons.menu),
        title: Text('Events'),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'PLAN',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('PLAN'),
                      backgroundColor: Colors.purple[700],
                    ),
                              body: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 2,
                    ),
                    markers: _markers.values.toSet(),
                  ),
                  );
                },
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'settings',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Parametrages'),
                    ),
                    body: const Center(
                      child: Text(
                        'Parametrages',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.purple,
      ),
    
     
      body: Center(
        child: 
         _widgetOptions.elementAt(_selectedIndex),
          
          // ElevatedButton(child: Text('click me'), onPressed: (){getData();})
        
        
        
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historique',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}

class User {
  final String name, email, username;
  User(this.name, this.email,this.username);
}
class Photo {
  final String id, title, thumbnailUrl;
  Photo(this.id, this.title,this.thumbnailUrl);
}






