import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/components/error_state.dart';
import 'package:flutter_real_estate/ui/components/list_card_house.dart';
import 'package:flutter_real_estate/ui/components/strings.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import '../../application/list_houses_provider.dart';
import '../../application/providers.dart';
import '../components/filter_card.dart';
import '../theme/colors.dart';

class OverviewScreen extends ConsumerWidget {
  // Controller for the search bar input field.
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the list of houses from the provider.
    final houseDataValue = ref.watch(listHousesProvider);

    // A provider for tracking if the search bar is empty or not.
    final textSearchBarIsEmptyProvider = StateProvider<bool>((ref) => true);

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
                      ref.watch(textSearchBarIsEmptyProvider)
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
                                FocusScopeNode currentFocus = FocusScope.of(context);

                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                  ref.read(textSearchBarIsEmptyProvider.notifier).update((state) => true);
                                }
                              },
                            ),
                ),
                border: InputBorder.none,
              ),
              onSubmitted: (value) {
                // Update the search text when the user presses enter.
                ref.read(textSearchBarProvider.notifier).update((_) => value);
              },
              onChanged: (value) {
                // Update the state of the search bar.
                ref.read(textSearchBarIsEmptyProvider.notifier).update((state) => value.isEmpty);
              },
            ),
          ),
        ),
      ),
      // House list section
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SizedBox(
          // Change your height based on preference
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
                    // Set the scroll direction to horizontal
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
          data: (houses) => ListCardHouse(houseList: houses),
          loading: () => Center(child: CircularProgressIndicator()),
          error: (e, __) => Center(child: ErrorState()),
        ),
      ),
    ]);
  }
}

