import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cacerolazo RD'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _stop = false;
  IconData _soundIndicator = Icons.play_arrow;
  AudioPlayer cacerolaSound;

  final player = AudioCache();
  void _soundControl() async {
    if (_stop) {
      var state = await cacerolaSound?.stop();
      setState(() {
        _soundIndicator = Icons.play_arrow;
      });

      print(state);
    } else {
      cacerolaSound = await player.loop('cacerolasound.mp3');
      setState(() {
        _soundIndicator = Icons.pause;
      });
    }
    print(_stop);
    _stop = !_stop;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.red,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/flagRD.png",
            ),
            Text(
              'Dale a play y únete a esta Revolución',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _soundControl,
        tooltip: 'Sound Activation',
        child: Icon(
          _soundIndicator,
          size: 50,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
