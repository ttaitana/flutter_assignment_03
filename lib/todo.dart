import 'package:flutter/material.dart';
import 'storage.dart';
import 'completed.dart';
import 'task.dart';

class toDoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return toDoState();
  }
}

class toDoState extends State<toDoPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final List<AppBar> appBars = <AppBar>[
      AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, '/new');
                // updateTask();
              })
        ],
      ),
      AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              Firestorage.delAll();
            },
          )
        ],
      ),
    ];

// ---------------- End Data Prepare -------------------------
  final List<Widget> _pages = <Widget>[
    Task(),
    Completed()
  ];

    return Scaffold(
      appBar: appBars[_currentIndex],
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
            primaryColor: Colors.blue,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.black54)),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), title: Text('Task')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_all), title: Text('Completed'))
            ],
            onTap: onTabTaped,
            currentIndex: _currentIndex,
          )),
    );
  }

  void onTabTaped(int index) {
    setState(() => _currentIndex = index);
  }
}
