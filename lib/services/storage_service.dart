import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_data_model.dart';

class StorageService extends ChangeNotifier {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  static const String _keyAppData = 'student_leave_app_data';

  AppDataModel _data = AppDataModel.defaults();
  bool _isInitialized = false;

  AppDataModel get data => _data;
  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_keyAppData);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        _data = AppDataModel.fromJson(jsonStr);
      } else {
        _data = AppDataModel.defaults();
        await save(_data);
      }
    } catch (e) {
      debugPrint('Error loading saved data: $e');
      _data = AppDataModel.defaults();
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<void> save(AppDataModel newData) async {
    _data = newData;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyAppData, newData.toJson());
    } catch (e) {
      debugPrint('Error saving data: $e');
    }
  }

  Future<void> resetToDefaults() async {
    final def = AppDataModel.defaults();
    await save(def);
  }
}
