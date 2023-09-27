import 'dart:convert';
import 'dart:io';
import 'package:flutter_real_estate/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/house_model.dart';
import 'api_exception.dart';

abstract class HouseRepository {
  Future<List<HouseData>> getListHouses();
}

class HttpHouseRepository implements HouseRepository {
  HttpHouseRepository({required this.client, required this.apiKey});

  final String apiKey;
  final http.Client client;

  @override
  Future<List<HouseData>> getListHouses() => _getData(
      uri: Uri.parse(Constants.houseAPIUrl),
      apiKey: {'Access-Key': apiKey},
      builder: (data) {
        List<HouseData> houseList = [];
        for (var item in data) {
          houseList.add(HouseData.fromJson(item));
        }
        return houseList;
      });

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
    required Map<String, String> apiKey,
  }) async {
    try {
      final response = await client.get(uri, headers: apiKey);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw NotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

final houseRepositoryProvider = Provider<HttpHouseRepository>((ref) {
  /// Use the API key passed via --dart-define,
  const apiKey = String.fromEnvironment(
    'API_KEY',
  );
  return HttpHouseRepository(
    apiKey: apiKey,
    client: http.Client(),
  );
});
