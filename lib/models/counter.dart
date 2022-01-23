import 'package:flutter/foundation.dart';
import 'package:nanoid/nanoid.dart';

class Counter {
  String id;
  int count;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }

  Counter(this.id, this.count);
}

class CountersModel with ChangeNotifier {
  Map<String, Counter> countersMap = {};

  void createCounter() {
    var id = nanoid();
    countersMap[id] = Counter(id, 0);
    notifyListeners();
  }
}
