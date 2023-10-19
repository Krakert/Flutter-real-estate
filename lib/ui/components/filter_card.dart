import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/selected_sort_provider.dart';
import '../../models/sort_model.dart';
import '../theme/colors.dart';
import '../theme/type.dart';

class FilterCard extends ConsumerWidget {
  const FilterCard({required this.text, required this.cardId, required this.selectedId});

  final String text;
  final int cardId;
  final int selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedState = ref.watch(selectedSortProvider);
    return GestureDetector(
      onTap: () {
        // Change the order type
        if (selectedId == cardId) {
          ref.read(selectedSortProvider.notifier).update((state) =>
              SortProviderModel(
              id: cardId, oder: state.oder == Order.asc ? Order.desc : Order.asc));
        } else {
          ref.read(selectedSortProvider.notifier).update((state) =>
              SortProviderModel(id: cardId, oder: Order.asc));
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
                width: 2, color: cardId == selectedId ? AppColors.dttRed : AppColors.medium),
            borderRadius: BorderRadius.circular(40),
          ),
          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: Row(
            children: [
              Visibility(
                  visible: selectedId == cardId,
                  child: Icon(
                    // Show different Icon base on the Order type
                    selectedState.oder == Order.desc ? Icons.arrow_downward : Icons.arrow_upward,
                    color: AppColors.medium,
                  )),
              Center(
                  child: Text(text,
                      style: AppTypography.hint.copyWith(
                          color: cardId == selectedId ? AppColors.dttRed : AppColors.medium))),
            ],
          ),
        ),
      ),
    );
  }
}
