import 'package:flutter/material.dart';
import 'package:flutter_real_estate/models/sort_model.dart';
import 'package:flutter_real_estate/ui/components/error_state.dart';
import 'package:flutter_real_estate/ui/components/strings.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../application/providers.dart';
import '../../models/house_model.dart';
import '../components/card_house.dart';
import '../components/empty_list_waring.dart';
import '../components/filter_card.dart';
import '../theme/colors.dart';

class OverviewScreen extends ConsumerWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the list of houses from the provider.
    final houseDataValue = ref.watch(listHousesProvider);
    final textSearchbarIsEmptyProvider =
        Provider<bool>((ref) => ref.watch(textSearchBarProvider).isEmpty);

    return Column(children: [
      // Search bar section
      Padding(
        padding: EdgeInsets.only(top: 0.75.h, bottom: 1.5.h, right: 4.2.w, left: 4.2.w),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 4.w, top: 0.4.h),
            child: TextField(
              controller: searchController,
              cursorColor: AppColors.medium,
              style: AppTypography.input,
              decoration: InputDecoration(
                hintText: Strings.searchBarHint,
                hintStyle: AppTypography.hint,
                suffixIcon: Consumer(
                  builder: (context, ref, _) =>
                      // Show search or clear button based on textSearchbarIsEmptyProvider.
                      ref.watch(textSearchbarIsEmptyProvider)
                          ? IconButton(
                              icon: const Icon(Icons.search, color: AppColors.medium),
                              onPressed: () {},
                            )
                          : IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.strong),
                              onPressed: () {
                                // Clear the search text when the clear button is pressed.
                                ref.read(textSearchBarProvider.notifier).update((_) => '');
                                searchController.clear();
                              },
                            ),
                ),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Update the search text when the user types.
                ref.read(textSearchBarProvider.notifier).update((_) => value);
              },
            ),
          ),
        ),
      ),
      // House list section
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SizedBox(
          // change your height based on preference
          height: 40,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: const Text(Strings.sortText, textAlign: TextAlign.left),
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) => ListView(
                    // set the scroll direction to horizontal
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      for (final (index, item) in Strings.filters.indexed)
                        FilterCard(
                            text: item,
                            cardId: index,
                            selectedId: ref.watch(selectedSortProvider).id)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Expanded(
        child: houseDataValue.when(
          skipLoadingOnRefresh: false,
          data: (houses) => ListViewWidget(houseList: houses),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (e, __) => Center(child: ErrorState()),
        ),
      ),
    ]);
  }
}

class ListViewWidget extends ConsumerWidget {
  final List<HouseData> houseList;

  const ListViewWidget({super.key, required this.houseList});

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

  bool isIncludeNumber(String str) {
    RegExp regex = RegExp(r'\d');
    return regex.hasMatch(str);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          return Center(
              child: CircularProgressIndicator()); // You can use any loading indicator widget here.
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Handle the case when the Future completed, but data is null.
          return const EmptyListWarning();
        } else {
          List<HouseData> filteredHouseList = snapshot.data!;

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
