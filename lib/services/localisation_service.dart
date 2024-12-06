import 'dart:convert';
import 'dart:developer';
import 'package:call_me_app/models/location.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

final dio = Dio();
const String backendUrl = 'http://192.168.1.111/service%20PHP';

class LocalisationService {
  Future<Either<String, List<Location>>> fetchLocations() async {
    try {
      final res = await dio.get('$backendUrl/get_all.php');
      final resData = jsonDecode(res.data);

      final locationList = resData['positions'] as List;
      final List<Location> fetchedLocations = locationList
          .map(
            (location) => Location.fromMap(location),
          )
          .toList();
      return right(fetchedLocations);
    } on DioException catch (e) {
      return left('Error while fetching positions: ${e.message}');
    }
  }

  Future<String> addLocation({
    required double latitude,
    required double longitude,
    required int number,
    required String pseudo,
  }) async {
    final Map<String, dynamic> locationData = {
      'latitude': latitude,
      'longitude': longitude,
      'numero': number,
      'pseudo': pseudo
    };
    log(jsonEncode(locationData));

    try {
      final response = await dio.post(
        '$backendUrl/add_position.php',
        data: jsonEncode(locationData),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        return '1';
      } else {
        return '0';
      }
    } catch (e) {
      return '0';
    }
  }

  Future<String> deletePosition(String pseudo) async {
    try {
      final response = await dio.delete(
        '$backendUrl/delete_position.php',
        data: jsonEncode({'pseudo': pseudo}),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return '1';
      } else {
        return '0';
      }
    } catch (e) {
      return "0";
    }
  }
}
