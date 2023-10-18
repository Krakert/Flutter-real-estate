import 'package:flutter_real_estate/models/sort_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

final selectedSortProvider =
    StateProvider<SortProviderModel>((ref) => SortProviderModel(id: 0, oder: Order.asc));

final textSearchBarProvider = StateProvider<String>((ref) => '');
