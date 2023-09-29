import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:sizer/sizer.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return (AppBar(
      backgroundColor: Colors.transparent,
      // Set the background color to transparent
      elevation: 0.0,
      // Set elevation to 0.0 to remove the shadow
      bottomOpacity: 0.0,
      flexibleSpace: Container(
        margin: EdgeInsets.only(left: 4.5.w, top: 5.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: AppTypography.title01
          ),
        ),
      ),
    ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}