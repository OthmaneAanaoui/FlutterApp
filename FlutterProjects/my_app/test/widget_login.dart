import 'dart:convert';
  import 'package:flutter/material.dart';

  void main() {
    runApp(MyApp());
  }

 class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
             title: 'Food recipe',
             debugShowCheckedModeBanner: false,
             theme: ThemeData(
                 primarySwatch: Colors.blue,
                 primaryColor: Colors.white,
                 textTheme: TextTheme(
                 bodyText2: TextStyle(color: Colors.white),
           ),
         ),
       home: DataFromApi(),
    );
   }
  }

  class DataFromApi extends StatefulWidget {
     @override
    _DataFromApiState createState() => _DataFromApiState();
   }         

  class _DataFromApiState extends State<DataFromApi> {
   Future<List<Data>> getData() async {
    var response =
     await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
     var jsonData = jsonDecode(response.body);
    List<Data> dataList = [];
    for (var u in jsonData) {
         Data data = Data(u["name"], u["phone"], u["email"]);
         dataList.add(data);
     }
    print(dataList.length);
    return dataList;
   }

   @override
   Widget build(BuildContext context) {
   return Scaffold(
   appBar: AppBar(
        title: Text("Data Fetch"),
    ),
   body: Container(
       child: Card(
         child: FutureBuilder<List<Data>>(
        future: getData(),
        builder: (context, snapshot) {
            if (snapshot.data == null) {
             return Container(
            child: Text("Loading"),
            );
         }else{
            return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        title: Column(
                        children: [
                              Text(snapshot.data![i].name),
                              Text(snapshot.data![i].phone),
                              Text(snapshot.data![i].email),
                        ],
                      ),
                    );
                 });
             }
          },
       ),
      ),
    ));
 }
}

class Data {
  final String name, phone, email;

  Data(this.name, this.phone, this.email);
}