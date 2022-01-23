import 'package:flutter/foundation.dart';
import 'package:nanoid/nanoid.dart';

class Counter {
  String id;
  int count;

  Counter(this.id, this.count);

  Counter clone() {
    return Counter(id, count);
  }
}

class CountersModel with ChangeNotifier {
  Map<String, Counter> countersMap = {};

  void createCounter() {
    var id = nanoid();
    countersMap[id] = Counter(id, 0);
    notifyListeners();
  }

  void increment(Counter counter) {
    counter.count++;
    countersMap[counter.id] = counter.clone();
    notifyListeners();
  }

  void decrement(Counter counter) {
    counter.count--;
    countersMap[counter.id] = counter.clone();
    notifyListeners();
  }
}
