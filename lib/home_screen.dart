import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Modal/userModal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<UserModal> users = [];

  Future<List<UserModal>> getusers() async{

    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      print("getting data from api");

      for(Map i in data){
        users.add(UserModal.fromJson(i));
      }

      return users;
    }
    else{
      return users;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const  Text('Complex Apis',style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(future: getusers(),builder: (context, AsyncSnapshot<List<UserModal>> snapshot){
            
            return ListView.builder(itemCount: users.length,itemBuilder: (context, index){
              return Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const  Text('Name'),
                          Text(snapshot.data![index].name.toString()),
                        ],
                      ),
                    )
                  ],
                ),
              );
            });
          }))
        ],
      ),
    );
  }
}
