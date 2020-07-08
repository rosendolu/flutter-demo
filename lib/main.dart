import 'package:flutter/material.dart';

void main() {
  runApp(new ParentWidgetA());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'myHomePage title',
        initCount: 100,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title, this.initCount: 0})
      : super(key: key);

  final int initCount;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter;

  static GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _counter = widget.initCount;
    print('init state');
    print(_counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text(
        //       'You have pushed the button this many times:',
        //     ),
        //     Text(
        //       '$_counter',
        //       style: Theme.of(context).textTheme.headline4,
        //     ),
        //   ],
        // ),
        child: new Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              // ScaffoldState _state =
              //     context.findAncestorStateOfType<ScaffoldState>();
              // ScaffoldState _state = Scaffold.of(context);
              // _state.showSnackBar(SnackBar(
              //   content: new Text('snackbar content'),
              // ));
              ScaffoldState _state = _globalKey.currentState;
              _state.openDrawer();
            },
            child: new Text('raised button'),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('update widget');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactive widget ');
  }
}

class TabboxA extends StatefulWidget {
  TabboxA({Key key}) : super(key: key);

  @override
  _TabboxAState createState() => _TabboxAState();
}

class _TabboxAState extends State<TabboxA> {
  bool _active = false;
  _setTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _setTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'active' : 'inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration:
            new BoxDecoration(color: _active ? Colors.lightGreen : Colors.grey),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  ParentWidget({Key key}) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;
  _setTapChange(bool val) {
    setState(() {
      _active = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new TapBoxB(acitve: _active, onChanged: _setTapChange));
  }
}

class TapBoxB extends StatelessWidget {
  TapBoxB({Key key, this.acitve: false, @required this.onChanged})
      : super(key: key);
  final ValueChanged<bool> onChanged;
  final bool acitve;
  void _handleTap() {
    onChanged(!acitve);
  }

  @override
  Widget build(BuildContext context) {
    var gestureDetector = new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            acitve ? 'active' : 'inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
            color: acitve ? Colors.lightGreen[300] : Colors.grey[300]),
      ),
    );
    return gestureDetector;
  }
}

class ParentWidgetA extends StatefulWidget {
  ParentWidgetA({Key key}) : super(key: key);

  @override
  _ParentWidgetAState createState() => _ParentWidgetAState();
}

class _ParentWidgetAState extends State<ParentWidgetA> {
  bool _active = false;
  void _setTap(bool val) {
    setState(() {
      _active = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: new TabboxB(active: _active, onChanged: _setTap));
  }
}

class TabboxB extends StatefulWidget {
  TabboxB({Key key, this.active = false, @required this.onChanged})
      : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;
  @override
  _TabboxBState createState() => _TabboxBState();
}

class _TabboxBState extends State<TabboxB> {
  bool _heightlight = false;
  void setTapDown(TapDownDetails details) {
    setState(() {
      _heightlight = true;
    });
  }

  void setTapUp(TapUpDetails details) {
    setState(() {
      _heightlight = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: setTapDown,
      onTapUp: setTapUp,
      child: new Container(
        child: new Center(
            child: new Text(
          widget.active ? 'active' : 'inactive',
          style: new TextStyle(fontSize: 32.0, color: Colors.green[300]),
          textDirection: TextDirection.ltr,
        )),
        width: 300.0,
        height: 300.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen : Colors.grey[300],
          border: _heightlight
              ? new Border.all(color: Colors.red, width: 10.0)
              : null,
        ),
      ),
    );
  }
}
