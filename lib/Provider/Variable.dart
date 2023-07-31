// ignore_for_file: file_names

import 'package:flutter/foundation.dart';

class NavBarVisibility with ChangeNotifier {
  bool _isVisible = true;

  bool get isVisible => _isVisible;

  void setVisible(bool visible) {
    _isVisible = visible;
    notifyListeners();
  }
}
