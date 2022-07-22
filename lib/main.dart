import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Page {
  const Page(this.subtreeKey, {required this.child});

  final GlobalKey subtreeKey;
  final Widget child;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _pageIndex = 1;

  final _pages = [
    Page(GlobalKey(), child: const Text('Hi')),
    Page(GlobalKey(), child: const Counter()),
  ];

  final _builtPages = List<bool>.generate(2, (_) => false);

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
      home: Scaffold(
        extendBody: _pageIndex == 1,
        appBar: AppBar(),
        body: Stack(
          fit: StackFit.expand,
          children: _pages.map(
            (page) {
              return _buildPage(
                _pages.indexOf(page),
                page,
              );
            },
          ).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Goto 0',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Goto 1',
            ),
          ],
          currentIndex: _pageIndex,
          onTap: (int index) {
            setState(() {
              _pageIndex = index;
            });
            debugPrint("idx " + _pageIndex.toString());
          },
        ),
      ),
    );
  }

  Widget _buildPage(
    int tabIndex,
    Page page,
  ) {
    final isCurrentlySelected = tabIndex == _pageIndex;

    _builtPages[tabIndex] = isCurrentlySelected || _builtPages[tabIndex];

    final Widget view = KeyedSubtree(
      key: page.subtreeKey,
      child: _builtPages[tabIndex] ? page.child : Container(),
    );

    if (tabIndex == _pageIndex) {
      return view;
    } else {
      return Offstage(child: view);
    }
  }
}

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);
  @override
  _CounterState createState() => _CounterState();
}

//this part is not important, just to show that state is lost
class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  void initState() {
    _count = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: Text(
          "Count: " + _count.toString(),
          style: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
    );
  }
}
