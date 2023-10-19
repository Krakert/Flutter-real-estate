import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to store the value of the search bar
final textSearchBarProvider = StateProvider<String>((ref) => '');
