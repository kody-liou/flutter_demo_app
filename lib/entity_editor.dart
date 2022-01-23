import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:deep_collection/deep_collection.dart';

abstract class Editable<T> {
  String id;
  bool selected;
  Editable(this.id, this.selected);
  Map<String, dynamic> toMap();
  void fromMap(Map map);
  T clone();
}

class Editor<T extends Editable<T>> {
  late T _original;
  late final T edit;
  late final FutureOr<Map> Function(Map) _doUpdate;
  late final void Function(T) _setItem;

  Editor(T editable, this._doUpdate, this._setItem) {
    _original = editable;
    edit = _original.clone();
  }
  Future<void> update() async {
    Map<String, dynamic> originalMap = _original.toMap();
    Map<String, dynamic> editMap = edit.toMap();
    Map difference = editMap.deepDifferenceByValue(originalMap);
    if (difference.isEmpty) return;
    Map result = await _doUpdate(difference);
    _original.fromMap(result);
    _setItem(_original);
  }
}

abstract class ItemsModel<T extends Editable<T>> with ChangeNotifier {
  /// The key is item's id.
  Map<String, T> itemsMap = {};

  /// Update server item.
  FutureOr<Map> updateServerItem(Map map);

  /// Set item to itemsMap and call notifyListeners.
  setItem(T item) {
    itemsMap[item.id] = item.clone();
    notifyListeners();
  }

  Editor<T> getEditor(T item) {
    return Editor(item, updateServerItem, setItem);
  }
}
