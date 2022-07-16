import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppStorage {
  ///box for storing data in the app
  Box<dynamic>? _box;

  /// for initialling app local storage
  Future<void> initAppStorage() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<Box<dynamic>>('hello world');
  }

  /// for clearing all data in box
  Future<void> clearAllData() async {
    await _box?.clear();
  }
}

/// provider app storage
final Provider<AppStorage> appStorageProvider = Provider<AppStorage>(
  (final _) {
    throw UnimplementedError();
  },
);
