import 'package:flutter/material.dart';

void main() {
  runApp(ParentWidgetA());
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
        child: Builder(builder: (context) {
          return RaisedButton(
            onPressed: () {
              // ScaffoldState _state =
              //     context.findAncestorStateOfType<ScaffoldState>();
              // ScaffoldState _state = Scaffold.of(context);
              // _state.showSnackBar(SnackBar(
              //   content:  Text('snackbar content'),
              // ));
              ScaffoldState _state = _globalKey.currentState;
              _state.openDrawer();
            },
            child: Text('raised button'),
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
    return GestureDetector(
      onTap: _setTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'active' : 'inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration:
            BoxDecoration(color: _active ? Colors.lightGreen : Colors.grey),
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
    return Container(child: TapBoxB(acitve: _active, onChanged: _setTapChange));
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
    var gestureDetector = GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            acitve ? 'active' : 'inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
            textDirection: TextDirection.ltr,
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
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
    return Container(child: TabboxB(active: _active, onChanged: _setTap));
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
    return GestureDetector(
      onTapDown: setTapDown,
      onTapUp: setTapUp,
      child: Container(
        child: Center(
          //     child:  Text(
          //   widget.active ? 'active' * 10 : 'inactive widget ' * 10,
          //   textAlign: TextAlign.left,
          //   maxLines: 2,
          //   overflow: TextOverflow.ellipsis,
          //   textScaleFactor: 1.5,
          //   style:  TextStyle(
          //       fontSize: 13.0,
          //       color: Colors.lightGreen[300],
          //       Color: Colors.grey,
          //       decorationStyle: TextDecorationStyle.double,
          //       decoration: TextDecoration.underline),
          //   textDirection: TextDirection.rtl,
          // )),
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: "home ", style: TextStyle(color: Colors.red)),
              TextSpan(
                  text: 'http://www.google.com/',
                  style: TextStyle(color: Colors.blue)),
            ]),
            textDirection: TextDirection.ltr,
          ),
        ),
        width: 300.0,
        height: 300.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen : Colors.grey[300],
          border:
              _heightlight ? Border.all(color: Colors.red, width: 10.0) : null,
        ),
      ),
    );
  }
}

class DefaultStyle extends StatelessWidget {
  const DefaultStyle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.greenAccent[300], fontSize: 20.0),
        textAlign: TextAlign.left,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('header h1'),
            Text('header h2'),
            Text(
              'hello h3',
              style: TextStyle(inherit: true),
            )
          ],
        ),
      ),
    );
  }
}
