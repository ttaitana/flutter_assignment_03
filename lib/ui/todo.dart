import 'package:flutter/material.dart';
import '../model/storage.dart';

class toDoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return toDoState();
  }
}

class toDoState extends State<toDoPage> {
  int _currentIndex = 0;

  final StorageProvider _storage = StorageProvider();
  List<Storage> _task = List<Storage>();
  List<Storage> _completed = List<Storage>();

  void loadData() {
    this._storage.getTask().then((data) {
      setState(() {
        this._task = data;
      });
    });

    this._storage.getComplete().then((data) {
      setState(() {
        this._completed = data;
      });
    });
  }

  @override
  initState() {
    super.initState();
    _storage.open('todo.db').then((s) => this.loadData());
    print('######################################');
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    // Variable
    Widget checkBoxsTask() {
      List<Widget> cbs = List();
      int counter = 1;
      for (var item in _task) {
        cbs.add(CheckboxListTile(
          title: Text(item.title),
          value: item.done,
          onChanged: (bool val) {
            setState(() {
              item.done = val;
              this._storage.update(item);
              this.loadData();
            });
          },
        ));
        if(counter < _task.length){
          cbs.add(
            Divider(color: Colors.black,)
          );
        }
        counter++;
      }
      // _task.map((f) => cbs.add(CheckboxListTile(
      //       title: Text(f.title),
      //       value: f.done,
      //     )));
      // cbs.add(CheckboxListTile(title: Text('Test'),value: false,));
      if (cbs.isEmpty) {
        return Center(
          child: Text("No data found.."),
        );
      }
      return ListView(
        children: cbs,
      );

      // return ListView.separated(
      //   itemCount: cbs.length,
      //   itemBuilder: ,
      // );
    }

    Widget checkBoxsComplete() {
      List<Widget> cbs = List();
      int counter = 1;
      for (var item in _completed) {
        cbs.add(CheckboxListTile(
          title: Text(item.title),
          value: item.done,
          onChanged: (bool val) {
            setState(() {
              item.done = val;
              this._storage.update(item);
              this.loadData();
            });
          },
        ));
        if(counter < _completed.length){
          cbs.add(
            Divider(color: Colors.black,)
          );
        }
      }
      // cbs.add(CheckboxListTile(title: Text('Test'),value: false,));
      if (cbs.isEmpty) {
        return Center(
          child: Text("No data found.."),
        );
      }
      return ListView(
        children: cbs,
      );
    }

    // ------------ Function ------------------
    void updateComplete() {
      this._storage.getComplete().then((data) {
        setState(() {
          this._completed = data;
        });
      });
    }

    void updateTask() {
      this._storage.getTask().then((data) {
        setState(() {
          this._task = data;
        });
      });
    }

    // Pages

    List<Widget> _pages = [
      checkBoxsTask(),

      // RaisedButton(
      //   child: Text("Click me"),
      //   onPressed: () async{
      //     Storage dd = await _storage.getData(1);
      //     for (var item in _task) {
      //       print(item.toMap());
      //     }
      //   },
      // ),
      checkBoxsComplete(),
    ];

    // End pages

    final List<AppBar> appBars = <AppBar>[
      AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await Navigator.pushNamed(context, '/new');
                updateTask();
              })
        ],
      ),
      AppBar(
        title: Text('Todo'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await _storage.delComplete();
              this.loadData();
            },
          )
        ],
      ),
    ];

// ---------------- End Data Prepare -------------------------

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
