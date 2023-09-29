import 'package:flutter/material.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';

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
                'Hello, I am Stefan de Kraker, a recently graduated Technical Informatics student with a great passion for hardware and software.'
                '\n\nDuring my studies I took a minor in mobile application development. Since then, my love and passion for mobile app development has only grown.'
                '\n\nAlthough developing mobile applications fell outside my regular course of study, I was determined to master new techniques and concepts. I hope my determination comes through in this app, because I haven\'t worked with Flutter before.'
                '\n\nI hope that DTT can look past this and give me a chance to become a top Flutter developer and thus further strengthen the DTT team.'
                '\n\nPlease also take a look at my Github for my personal projects such as my smartwatch app and LinkedIn for more information about my background.',
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
