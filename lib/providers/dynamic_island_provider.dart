import 'package:flutter/cupertino.dart';

enum Island {
  name,
  speaking,
  copying,
  deleting,
  sharing,
  loading,
  cancelling,
}

class DynamicIslandProvider extends ChangeNotifier {
  Island _island = Island.name;

  Island get island => _island;

  void setIslandValue(Island island) async {
    Island prevIsland = _island;
    if (island == Island.loading) {
      _island = island;
      notifyListeners();
    } else {
      _island = island;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 900));
      if (prevIsland == Island.loading) {
        _island = prevIsland;
      } else {
        _island = Island.name;
      }
      notifyListeners();
    }
  }

  void setLoadingDone() {
    _island = Island.name;
    notifyListeners();
  }
}
