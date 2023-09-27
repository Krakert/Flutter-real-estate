
import 'package:flutter_real_estate/data/house_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/house_model.dart';

final listHousesProvider = FutureProvider.autoDispose<List<HouseData>>((ref) async {
  return ref.watch(houseRepositoryProvider).getListHouses();
});