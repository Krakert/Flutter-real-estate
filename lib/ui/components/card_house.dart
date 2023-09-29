import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../models/house_model.dart';
import '../../utils/constants.dart';
import '../screens/detail_screen.dart';
import '../theme/colors.dart';
import '../theme/type.dart';

class CardHouse extends StatelessWidget {
  const CardHouse({required this.house, required this.showDistance});

  final HouseData house;
  final bool? showDistance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the DetailScreen when the card is tapped.
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => DetailScreen(selectedItem: house),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.75.h, horizontal: 4.w),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.lightGray,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: AppColors.white,
          ),
          height: 15.5.h,
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child: Row(
              children: [
                // Display the house image with a hero animation.
                Hero(
                  tag: house.id,
                  child: CachedNetworkImage(
                    imageUrl: Constants.baseAPIUrl + house.image,
                    placeholder: (context, url) => SizedBox(width: 22.w, height: 22.h),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 22.w,
                      height: 22.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display the house price with commas.
                      Text(
                        '\$${house.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: AppTypography.title02,
                      ),
                      SizedBox(height: 3.0),
                      // Display the house zip code and city.
                      Text(
                        '${house.zip} ${house.city}',
                        style: AppTypography.body,
                      ),
                      SizedBox(height: 33.0),
                      Row(
                        children: [
                          // Display the number of bedrooms.
                          SvgPicture.asset(
                            'assets/icons/ic_bed.svg',
                            width: 2.h,
                            height: 2.h,
                            colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 3.0),
                          Text(
                            house.bedrooms.toString(),
                            style: AppTypography.detail,
                          ),
                          const SizedBox(width: 24.0),
                          // Display the number of bathrooms.
                          SvgPicture.asset(
                            'assets/icons/ic_bath.svg',
                            width: 2.h,
                            height: 2.h,
                            colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 3.0),
                          Text(
                            house.bathrooms.toString(),
                            style: AppTypography.detail,
                          ),
                          const SizedBox(width: 24.0),
                          // Display the house size.
                          SvgPicture.asset(
                            'assets/icons/ic_layers.svg',
                            width: 2.h,
                            height: 2.h,
                            colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 2.0),
                          Expanded(
                            child: Text(
                              house.size.toString(),
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.detail,
                            ),
                          ),
                          // Display distance and location icon if showDistance is true.
                          Visibility(
                            visible: showDistance ?? false,
                            child: SvgPicture.asset(
                              'assets/icons/ic_location.svg',
                              width: 2.h,
                              height: 2.h,
                              colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                            ),
                          ),
                          const SizedBox(width: 2.0),
                          Visibility(
                            visible: showDistance ?? false,
                            child: Text(
                              '${house.distance}km',
                              style: AppTypography.detail,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
