import 'package:flutter/material.dart';

class InfiniteScrollController extends ChangeNotifier {
  List<Widget> items = [];

  void addItem(Widget item) {
    items.add(item);
    notifyListeners();
  }

  void clearItems() {
    items.clear();
    notifyListeners();
  }
}

class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({required this.controller, Key? key}) : super(key: key);

  final InfiniteScrollController controller;
  @override
  State<StatefulWidget> createState() {
    return _InfiniteScrollState();
  }
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  List<Widget> items = [];
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        items = [...widget.controller.items];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.controller.items,
    );
  }
}
