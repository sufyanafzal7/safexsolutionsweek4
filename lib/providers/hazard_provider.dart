import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hazard_model.dart';
import '../utils/dummy_data.dart';

class HazardProvider with ChangeNotifier {
  static const String _storageKey = 'safex_hazards_list';
  List<HazardModel> _hazards = [];
  bool _isLoading = true;

  List<HazardModel> get hazards => _hazards;
  bool get isLoading => _isLoading;

  int get openCount => _hazards.where((h) => h.status == HazardStatus.Open).length;
  int get inProgressCount => _hazards.where((h) => h.status == HazardStatus.InProgress).length;
  int get resolvedCount => _hazards.where((h) => h.status == HazardStatus.Resolved).length;

  HazardProvider() {
    loadHazards();
  }

  Future<void> loadHazards() async {
    _isLoading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedJsonList = prefs.getStringList(_storageKey);

    if (storedJsonList != null && storedJsonList.isNotEmpty) {
      _hazards = storedJsonList.map((item) => HazardModel.fromJson(item)).toList();
    } else {
      _hazards = DummyData.initialHazards;
      await _saveToStorage();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addHazard(HazardModel hazard) async {
    _hazards.insert(0, hazard);
    notifyListeners();
    await _saveToStorage();
  }

  Future<void> updateHazardStatus(String id, HazardStatus newStatus) async {
    final index = _hazards.indexWhere((h) => h.id == id);
    if (index != -1) {
      _hazards[index].status = newStatus;
      notifyListeners();
      await _saveToStorage();
    }
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = _hazards.map((h) => h.toJson()).toList();
    await prefs.setStringList(_storageKey, jsonList);
  }
}