import 'package:flutter/material.dart';
import 'storage.dart';

class newSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return newSubjectState();
  }
}

class newSubjectState extends State<newSubject> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController titleCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Subject'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: 'Subject'),
                  controller: titleCtrl,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please fill subject';
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if(this._formkey.currentState.validate()){
                      Firestorage.addTask(this.titleCtrl.text.trim());
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
