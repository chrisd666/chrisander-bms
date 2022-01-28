import 'package:flutter/material.dart';

class SidebarProvider with ChangeNotifier {
  bool _isOpen = false;

  bool get isOpen => _isOpen;

  void toggleSidebar() {
    _isOpen = !_isOpen;
    notifyListeners();
  }
}
