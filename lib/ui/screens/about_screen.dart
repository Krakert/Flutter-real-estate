import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../components/strings.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.5.w, vertical: 0.5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.aboutText,
                style: AppTypography.body,
              ),
              SizedBox(height: 4.h),
              InkWell(
                  child: Text(
                    "Github repository",
                    style: AppTypography.body.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                  onTap: () => launchUrl(Uri.parse(Constants.githubUrl))),
              InkWell(
                  child: Text(
                    "LinkedIn",
                    style: AppTypography.body.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                  onTap: () => launchUrl(Uri.parse(Constants.linkedinUrl))),
              SizedBox(height: 4.h),
              const Text(
                "Design and Development",
                style: AppTypography.title02,
              ),
              SizedBox(height: 2.h),
              Row(children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/dtt_banner/xxhdpi/dtt_banner.png',
                    fit: BoxFit.contain,
                    width: 150,
                  ),
                ),
                SizedBox(width: 6.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("by DTT", style: AppTypography.input),
                    SizedBox(height: 0.3.h),
                    Center(
                      child: InkWell(
                          child: Text(
                            "d-tt.nl",
                            style: AppTypography.body.copyWith(
                              color: Colors.blueAccent,
                            ),
                          ),
                          onTap: () => launchUrl(Uri.parse(Constants.dttHomeUrl))),
                    )
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    ]);
  }
}
