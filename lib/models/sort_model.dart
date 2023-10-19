enum Order { asc, desc }

// Class to keep track of the sorting type and order in the overview page
class SortProviderModel {
  late final int id;
  final Order oder;

  SortProviderModel({required this.id, required this.oder});
}
