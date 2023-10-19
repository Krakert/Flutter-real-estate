import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/location_permissions_provider.dart';
import '../../application/selected_sort_provider.dart';
import '../../application/text_searchbar_provider.dart';
import '../../models/house_model.dart';
import '../../models/sort_model.dart';
import 'card_house.dart';
import 'empty_list_warning.dart';

class ListCardHouse extends ConsumerWidget {
  final List<HouseData> houseList;

  const ListCardHouse({super.key, required this.houseList});

  // Function to filter the list of houses based on search text.
  Future<List<HouseData>> filterHouseList(String searchText) async {
    if (searchText.isEmpty) {
      // If searchText is empty, return the original houseList.
      return houseList;
    } else {
      // Convert searchText to lowercase for case-insensitive comparison.
      final lowerSearchText = searchText.toLowerCase();

      return houseList.where((house) {
        // Convert city and zip to lowercase for case-insensitive comparison.
        final lowerCity = house.city.toLowerCase();
        final lowerZip = house.zip.toLowerCase();

        // Split searchText into an array of search terms.
        final searchTextArr = lowerSearchText.split(RegExp(r'(?<=\D)\s'));

        for (final text in searchTextArr) {
          if (text.isEmpty) continue; // Skip empty search terms.

          // Check if the current search term matches city or postal code.
          if ((lowerCity.contains(text) || lowerZip.contains(text)) ||
              (searchTextArr.length > 1 &&
                  (isIncludeNumber(text) ? lowerZip.contains(text) : lowerCity.contains(text)))) {
            return true; // Return true if any search term matches.
          }
        }
        return false; // Return false if no match is found.
      }).toList();
    }
  }

  // Function to check if a string contains a number.
  bool isIncludeNumber(String str) {
    RegExp regex = RegExp(r'\d');
    return regex.hasMatch(str);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get information from various providers.
    final showDistance = ref.watch(locationPermissionProvider);
    final searchText = ref.watch(textSearchBarProvider);
    final sortOrder = ref.watch(selectedSortProvider);

    return FutureBuilder<List<HouseData>>(
      future: filterHouseList(searchText),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const EmptyListWarning();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          // Handle the case when the Future is still loading.
          return Center(child: CircularProgressIndicator()); // You can use any loading indicator widget here.
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle the case when the Future completed, but data is null.
          return const EmptyListWarning();
        } else {
          List<HouseData> filteredHouseList = snapshot.data!;

          // Sort the filtered house list based on the selected sort order.
          filteredHouseList.sort((a, b) {
            switch (sortOrder.id) {
              case 0:
                return sortOrder.oder == Order.asc
                    ? a.price.compareTo(b.price)
                    : b.price.compareTo(a.price);
              case 1:
                return sortOrder.oder == Order.asc
                    ? a.distance.compareTo(b.distance)
                    : b.distance.compareTo(a.distance);
              case 2:
                return sortOrder.oder == Order.asc
                    ? a.bathrooms.compareTo(b.bathrooms)
                    : b.bathrooms.compareTo(a.bathrooms);
              case 3:
                return sortOrder.oder == Order.asc
                    ? a.bedrooms.compareTo(b.bedrooms)
                    : b.bedrooms.compareTo(a.bedrooms);
              case 4:
                return sortOrder.oder == Order.asc
                    ? a.size.compareTo(b.size)
                    : b.size.compareTo(a.size);
            }
            // Default sorting if none of the cases match
            return 0;
          });

          // Build a list view of filtered and sorted house items.
          return ListView.builder(
            itemCount: filteredHouseList.length,
            itemBuilder: (BuildContext context, int index) {
              final house = filteredHouseList[index];
              return CardHouse(house: house, showDistance: showDistance.value);
            },
          );
        }
      },
    );
  }
}
