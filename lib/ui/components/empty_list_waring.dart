import 'package:flutter/cupertino.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:sizer/sizer.dart';

class EmptyListWarning extends StatelessWidget {
  const EmptyListWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/search_state_empty.png',
            width: 100.w,
            height: 25.h,
          ),
          const Text(
            'No results found! \nPerhaps try another search?',
            textAlign: TextAlign.center,
            style: AppTypography.hint,
          ),
        ],
      ),
    );
  }
}