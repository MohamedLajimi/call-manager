import 'dart:math';

import 'package:call_me_app/models/location.dart';
import 'package:call_me_app/services/localisation_service.dart';
import 'package:flutter/material.dart';

class LocalisationProvider extends ChangeNotifier {
  final LocalisationService _localisationService;
  LocalisationProvider(this._localisationService);
  List<Location> _locations = [];

  List<Location> get locations => _locations;

  void fetchLocations({required void Function(String) onError}) async {
    log(1);
    final res = await _localisationService.fetchLocations();
    res.fold(
      (error) {
        onError(error);
      },
      (fetchedLocations) {
        _locations = fetchedLocations;
        notifyListeners();
      },
    );
  }

  Future<String> addLocation({
    required double latitude,
    required double longitude,
    required int number,
    required String pseudo,
  }) async {
    final res = await _localisationService.addLocation(
        latitude: latitude,
        longitude: longitude,
        number: number,
        pseudo: pseudo);
    if (res == '1') {
      locations.add(Location(
          id: 'id',
          latitude: latitude,
          longitude: longitude,
          number: number,
          pseudo: pseudo));
      notifyListeners();
      return 'Position added successfully';
    } else {
      return 'Error while adding a new position';
    }
  }

  Future<String> deleteLocation({
    required String pseudo,
  }) async {
    final res = await _localisationService.deletePosition(pseudo);
    locations.removeWhere(
      (element) => element.pseudo == pseudo,
    );
    notifyListeners();
    return res == '1'
        ? 'Position deleted successfully'
        : 'Error while adding a new position';
  }
}
