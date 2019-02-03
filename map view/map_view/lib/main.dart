import 'package:flutter/material.dart';
import 'venues.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Map View',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Map View'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              child: const Text('Venues',semanticsLabel: 'Venues',),
              onPressed: () {
                Navigator.push(
                  context, 
                  new MaterialPageRoute(
                    builder: (context) => new Venues()
                  )
                );
              } ,
            ),
          ),
        ],),
      ),
    );
  }

}