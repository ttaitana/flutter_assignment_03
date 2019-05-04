import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'storage.dart';

Firestore _store = Firestore.instance;

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TaskState();
  }
}

class TaskState extends State<Task> {
  @override 

  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('todo').where('done', isEqualTo: false).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError){
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState){
          case ConnectionState.waiting:
            return Center(
              child: Text('Loading..'),
            );
          default:
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return 
                Column(
                  children: <Widget>[
                    CheckboxListTile(
                  title: Text(document['title']),
                  value: document['done'],
                  onChanged: (bool val){
                    Firestorage.update(document.documentID, val);
                  },
                ),
                    Divider(color: Colors.black38,)
                  ],
                );
              }).toList(),
            );
        }
      }
    );
  }
}
