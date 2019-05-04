import 'package:flutter/material.dart';
import '../model/storage.dart';

class Completed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CompletedState();
  }

}

class CompletedState extends State<Completed>{
  final StorageProvider _storage = StorageProvider();
  List<Storage> _task = List<Storage>();
  List<Storage> _completed = List<Storage>();

  // ------------ Function ------------------
  void updateComplete() {
    this._storage.getComplete().then((lst) {
      setState(() {
        this._completed = lst;
      });
    });
  }

  void updateTask() {
    this._storage.getTask().then((lst) {
      setState(() {
        this._task = lst;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Text("This is Completed"),
          )
        ],
      ),
    );
  }

}