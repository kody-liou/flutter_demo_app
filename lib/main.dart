import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo_app/helpers/create_file_from_asset.dart';
import 'package:flutter_demo_app/widgets/file_gallery.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<File> files = [];
  Future<void> init() async {
    final file1 = await createFileFromAsset('assets/images/dog1.jpg');
    final file2 = await createFileFromAsset('assets/images/dog2.jpg');
    setState(() {
      files = [
        file1,
        file2,
        file1,
        file2,
        file1,
        file2,
        file1,
        file2,
        file1,
        file2
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: GalleryView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> tiles = [];

  void swapTiles() {
    setState(() {
      tiles.insert(tiles.length - 1, tiles.removeAt(0));
    });
  }

  @override
  void initState() {
    tiles = [
      // const StatelessTile(color: Colors.blue),
      // const StatelessTile(),
      const StatefulTile(color: Colors.red),
      const StatefulTile(color: Colors.pink),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: SizedBox(height: 30, child: Row(children: tiles)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class StatelessTile extends StatelessWidget {
  const StatelessTile({Key? key, this.color = Colors.white}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: color,
      ),
    );
  }
}

class StatefulTile extends StatefulWidget {
  const StatefulTile({Key? key, this.color = Colors.white}) : super(key: key);
  final Color color;

  @override
  _StatefulTileState createState() => _StatefulTileState();
}

class _StatefulTileState extends State<StatefulTile> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        color: widget.color,
      ),
    );
  }
}
