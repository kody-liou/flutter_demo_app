import 'package:nanoid/nanoid.dart';
import '../entity_editor.dart';

class Counter extends Editable<Counter> {
  int count;

  Counter(String id, this.count, {bool selected = false}) : super(id, selected);
  @override
  Counter clone() {
    return Counter(id, count);
  }

  @override
  void fromMap(Map map) {
    id = map['id'];
    count = map['count'];
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['count'] = count;
    return map;
  }
}

class CountersModel extends ItemsModel<Counter> {
  @override
  Future<Map> updateServerItem(Map map) async {
    return map;
  }

  void createCounter() {
    var id = nanoid();
    setItem(Counter(id, 0));
  }

  void increment(Counter counter) {
    counter.count++;
    setItem(counter);
  }

  void decrement(Counter counter) {
    counter.count--;
    setItem(counter);
  }
}
