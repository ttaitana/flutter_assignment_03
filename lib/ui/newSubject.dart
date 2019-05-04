import 'package:flutter/material.dart';
import '../model/storage.dart';

class newSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return newSubjectState();
  }
}

class newSubjectState extends State<newSubject> {
  final StorageProvider _storage = StorageProvider();
  final _formkey = GlobalKey<FormState>();

  TextEditingController titleCtrl = TextEditingController();

  @override
  initState() {
    super.initState();
    _storage.open('todo.db');
    print('######################################');
    print('initNew');
  }

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
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      Storage data = Storage();
                      data.title = titleCtrl.text;
                      data.done = false;
                      print('Wait');
                      // await _storage.insert(data);
                      Storage result = await _storage.insert(data);
                      // print('######################################');
                      // print(result.id);
                      // print(result.title);
                      // print(result.done);
                      print('Completed');
                      // _storage.close();
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
