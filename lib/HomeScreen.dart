import 'package:chat_project/AddRoomScreen.dart';
import 'package:chat_project/LoginScreen.dart';
import 'package:chat_project/RoomGridItem.dart';
import 'package:chat_project/data/FirebaseUtils.dart';
import 'package:chat_project/providers/AuthProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/Room.dart';

class HomeScreen extends StatelessWidget{

  static const String routename = 'home';
  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    provider=Provider.of<AuthProvider>(context);
    return Container(
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            image:DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/background.png')
            )
        ),

        child: Scaffold(
          appBar: AppBar(
            title: Text('Chat App'),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  provider.deleteuser();
                  Navigator.pushReplacementNamed(context, LoginScreen.routename);

                  // do something
                },
              )
            ],

          ),
          floatingActionButton: FloatingActionButton(onPressed: () {
            Navigator.pushNamed(context, AddRoomScreen.routename);
          },child: Icon(Icons.add)),
          body: StreamBuilder<QuerySnapshot<Room>>(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var roomsList =
            snapshot.data?.docs.map((e) => e.data()).toList();
              return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: .9
              ), itemBuilder: (contextt,index){
                return RoomGridItem(roomsList!.elementAt(index));
              },itemCount: roomsList.length,) ;

          },
          stream: getRoomcollectionwithconverter().snapshots() ,),
        ),
      ),
    );
  }
}
