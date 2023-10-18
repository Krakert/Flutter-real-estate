import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/components/strings.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/list_houses_provider.dart';
import '../theme/colors.dart';

class ErrorState extends ConsumerWidget {
  const ErrorState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          Strings.errorText,
          textAlign: TextAlign.center,
          style: AppTypography.hint,
        ),
        SizedBox(height: 16.0),
        SizedBox(
          width: 200,
          child: GestureDetector(
            onTap: () {
              ref.invalidate(listHousesProvider);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(width: 2, color: AppColors.dttRed),
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.autorenew,
                      size: 24,
                      color: AppColors.medium,
                    ),
                    Text(Strings.reloadText,
                        style: AppTypography.hint.copyWith(color: AppColors.medium)),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
