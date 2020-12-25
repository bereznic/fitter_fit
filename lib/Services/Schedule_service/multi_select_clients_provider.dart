import 'package:flutter/foundation.dart';

class MultiSelectClients extends ChangeNotifier {
  List<String> selectedClients = [];

  void selectClient(String clientId) {
    selectedClients.add(clientId);
    notifyListeners();
  }

  void deselectClient(String clientId) {
    selectedClients.remove(clientId);
    notifyListeners();
  }

  void deselectAllClients() {
    selectedClients.clear();
    notifyListeners();
  }

  bool isSelected(String clientId) {
    if (selectedClients.contains(clientId)) return true;
    return false;
  }
}
