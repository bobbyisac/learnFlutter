import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location_services;

/*Location _getStartingLocation() async {
  var location = location_services.Location();
  Map<String, double> _currentLocation;
    _currentLocation = await location.getLocation();
  return Location(_currentLocation["latitude"], _currentLocation["longitude"]);
}

Location startingLocation = await _getStartingLocation();
*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Name',
      theme: new ThemeData(
        primaryColor: Colors.green,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];  
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if(index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap:() {
        setState(() {
                  if(alreadySaved){
                    _saved.remove(pair);
                  } else {
                    _saved.add(pair);
                  }
                });
      },
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Name'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children : <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
            ),
            ListTile(
              title: Text('View Map'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  //_viewMap();
                  Navigator.of(context).push(
                    new MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return new Scaffold(
                          appBar: new AppBar(
                            title: const Text('Map'),
                          ),
                          body: new Column(
                            children: <Widget> [
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: GoogleMap(
                                  initialCameraPosition: new CameraPosition(),
                                  onMapCreated: (GoogleMapController controller) {
                                    //my code
                                    /*controller.animateCamera(CameraUpdate.newCameraPosition(
                                      const CameraPosition(
                                        bearing: 270.0,
                                        target: LatLng(51.5160895, -0.1294527),
                                        tilt: 30.0,
                                        zoom: 17.0,
                                      )
                                    ));*/
                                    //
                                  },
                                ),
                              )
                            ]
                          ),
                        );

                      },
                    ),
                  );
                  //Navigator.pop(context);
                  },
            ),
          ]
        )
      ),
    );
  }
  /*void _viewMap(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Map'),
            ),
            
          );
        },
      ),
    );
    Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          onMapCreated: (GoogleMapController controller) {},
                        ),
                      ),
                    ],
    ),
  }*/
  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
          return new Scaffold(
            appBar: new AppBar(
              title: const Text('Saved Names'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
