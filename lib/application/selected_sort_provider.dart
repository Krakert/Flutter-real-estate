import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/sort_model.dart';

// Provider to keep track of the selected sorting type and order
final selectedSortProvider = StateProvider<SortProviderModel>((ref) => SortProviderModel(id: 0, oder: Order.asc));