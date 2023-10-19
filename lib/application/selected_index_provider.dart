import 'package:flutter_riverpod/flutter_riverpod.dart';

// Keeps track of the page to show
final selectedIndexProvider = StateProvider<int>((ref) => 0);
