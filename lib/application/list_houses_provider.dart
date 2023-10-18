import 'dart:convert' show json;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../data/api_exception.dart';
import '../models/house_model.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';

final listHousesProvider = FutureProvider<List<HouseData>>((ref) async {
  final client = http.Client();
  final uri = Uri.parse(Constants.houseAPIUrl);
  // Use the API key passed via --dart-define,
  const apiKey = {
    'Access-Key': String.fromEnvironment(
      'API_KEY',
    )
  };
  final response = await client.get(uri, headers: apiKey);
  final List<HouseData> houseList = [];
  switch (response.statusCode) {
    case 200:
      final data = json.decode(response.body);

      for (var houseData in data) {
        int latitude = houseData['latitude'];
        int longitude = houseData['longitude'];
        double distance = await Helper.calculateDistance(latitude.toDouble(), longitude.toDouble());

        final house = HouseData.fromJson(houseData);
        final houseWithDistance = HouseData(
            id: house.id,
            price: house.price,
            image: house.image,
            zip: house.zip,
            bathrooms: house.bathrooms,
            bedrooms: house.bedrooms,
            size: house.size,
            city: house.city,
            description: house.description,
            latitude: house.latitude,
            longitude: house.longitude,
            distance: double.parse(distance.toStringAsFixed(1)));
        houseList.add(houseWithDistance);
      }
    case 401:
      throw InvalidApiKeyException();
    case 404:
      throw NotFoundException();
    default:
      throw UnknownException();
  }
  return houseList;
});
