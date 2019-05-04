import 'package:flutter/material.dart';
import '../model/storage.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TaskState();
  }
}

class TaskState extends State<Task> {
  @override
  final StorageProvider _storage = StorageProvider();
  List<Storage> _task = List<Storage>();
  List<Storage> _completed = List<Storage>();

  void updateTask() {
    this._storage.getTask().then((lst) {
      setState(() {
        this._task = lst;
      });
    });
  }

  List<Widget> checkBoxs() {
    List<Widget> cbs = List();
    _task.map((f) => cbs.add(CheckboxListTile(
          title: Text(f.title),
          value: f.done,
        )));
    // cbs.add(CheckboxListTile(title: Text('Test'),value: false,));
    if (cbs.isEmpty) {
      print(
          '*********************************************************************************');
      print(cbs.length);
      return [Text("No data found..")];
    }
    return cbs;
  }

  

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: checkBoxs(),
      ),
    ));
  }
}
