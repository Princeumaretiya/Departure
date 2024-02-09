import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class JsonLoad with ChangeNotifier {
  Map? _jsonData;
  bool isLoading = false;

  Map? get jsonData => _jsonData;

  set setJsonData(value) {
    _jsonData = value;
    notifyListeners();
  }

  Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('asset/JsonData/bhagvat.json');
    print(jsonString);
    _jsonData = await jsonDecode(jsonString);
    print(_jsonData);

    notifyListeners();
  }
}

