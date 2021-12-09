



/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toulouse Events'),
        actions: <Widget>[
          
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
        ],
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
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}

class User {
  final String name, email, username;
  User(this.name, this.email,this.username);
}
