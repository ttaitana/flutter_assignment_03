import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'storage.dart';

class Completed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CompletedState();
  }

}

class CompletedState extends State<Completed>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todo').where('done', isEqualTo: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text('Error : ${snapshot.error}');
        }
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading..'),
            );
            default:
              return ListView(
                children: snapshot.data.documents.map((DocumentSnapshot doc){
                  return Column(
                  children: <Widget>[
                    CheckboxListTile(
                  title: Text(doc['title']),
                  value: doc['done'],
                  onChanged: (bool val){
                    Firestorage.update(doc.documentID, val);
                  },
                ),
                    Divider(color: Colors.black38,)
                  ],
                );
                }).toList(),
              );
        }
      },
    );
  }

}