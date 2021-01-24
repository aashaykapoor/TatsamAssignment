import 'package:flutter/cupertino.dart';
import 'package:tatsamAssignment/httpService.dart';
import 'package:tatsamAssignment/models/country.dart';

class CountryProvider extends ChangeNotifier {
  List<Country> _countries = [];
  List<Country> _favorites = [];
  int _offset = 0;
  int _limit = 10;
  bool _isEndOfList = false;

  void getcountries() async {
    _isEndOfList = false;
    final results =
        await HttpService().getCountries(_offset.toString(), _limit.toString());
    this._countries = results;
    _offset += _limit;
    notifyListeners();
  }

  void getMoreCountries() async {
    final results =
        await HttpService().getCountries(_offset.toString(), _limit.toString());
    if (results.isEmpty) {
      _isEndOfList = true;
      notifyListeners();
      return;
    }
    this.contries.addAll(results);
    _offset += _limit;

    notifyListeners();
  }

  List<Country> get contries => _countries;
  List<Country> get favorites => _favorites;
  bool get isEndOfList => _isEndOfList;

  void addToFavorites(Country country) {
    _favorites.add(country);
    notifyListeners();
  }

  void deleteFavorite(Country country) {
    _favorites.remove(country);
    notifyListeners();
  }

  bool isFavorite(Country country) {
    return _favorites.contains(country);
  }
}
