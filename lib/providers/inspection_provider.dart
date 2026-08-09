import 'package:flutter/material.dart';
import '../models/inspection_model.dart';
import '../utils/dummy_data.dart';

class InspectionProvider with ChangeNotifier {
  final List<InspectionItem> _items = DummyData.defaultChecklist;

  List<InspectionItem> get items => _items;

  int get totalItems => _items.length;
  int get passedItems => _items.where((item) => item.isPassed).length;

  double get compliancePercentage {
    if (totalItems == 0) return 100.0;
    return (passedItems / totalItems) * 100;
  }

  void toggleStatus(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      _items[index].isPassed = !_items[index].isPassed;
      notifyListeners();
    }
  }

  void resetChecklist() {
    for (var item in _items) {
      item.isPassed = true;
    }
    notifyListeners();
  }
}