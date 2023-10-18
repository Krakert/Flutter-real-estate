import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/models/house_model.dart';
import 'package:flutter_real_estate/ui/components/strings.dart';
import 'package:flutter_real_estate/ui/components/top_app_bar.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../theme/colors.dart';

class DetailScreen extends StatelessWidget {
  // Constructor to initialize the DetailScreen widget with the selected property.
  DetailScreen({Key? key, required this.selectedItem}) : super(key: key);

  // Property data for the selected property.
  final HouseData selectedItem;

  // Function to open the maps app with a given latitude and longitude.
  void launchMapsApp(double latitude, double longitude) async {
    String mapsUrl;
    if (Platform.isAndroid) {
      mapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    } else if (Platform.isIOS) {
      mapsUrl = 'http://maps.apple.com/?daddr=$latitude,$longitude';
    } else {
      throw 'Platform not supported.';
    }
    Uri uri = Uri.parse(mapsUrl);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: TopAppBar(
          title: '',
        ),
        body: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Display the property image with a hero tag.
              SizedBox(
                height: MediaQuery.of(context).orientation == Orientation.portrait ? 250 : 200,
                child: SingleChildScrollView(
                  child: Hero(
                    tag: selectedItem.id,
                    child: CachedNetworkImage(
                      imageUrl: Constants.baseAPIUrl + selectedItem.image,
                      fit: BoxFit.contain,
                      // Placeholder for the image while loading.
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      // Widget displayed when an error occurs while loading the image.
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  // Decorative container for property details.
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 4.h, bottom: 1.h),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                // Format the property price with commas.
                                '\$${selectedItem.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: AppTypography.title01,
                              )),
                              // Add all icons with their associated values
                              SizedBox(width: 1.w),
                              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_bed.svg',
                                  width: 2.h,
                                  height: 2.h,
                                  colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  selectedItem.bedrooms.toString(),
                                  style: AppTypography.detail,
                                ),
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  'assets/icons/ic_bath.svg',
                                  width: 2.h,
                                  height: 2.h,
                                  colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  selectedItem.bathrooms.toString(),
                                  style: AppTypography.detail,
                                ),
                                SizedBox(width: 4.w),
                                SvgPicture.asset(
                                  'assets/icons/ic_layers.svg',
                                  width: 2.h,
                                  height: 2.h,
                                  colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  selectedItem.size.toString(),
                                  style: AppTypography.detail,
                                ),
                                SizedBox(width: 4.w),
                                Visibility(
                                  visible: selectedItem.distance == 0.0 ? false : true,
                                  child: SvgPicture.asset(
                                    'assets/icons/ic_location.svg',
                                    width: 2.h,
                                    height: 2.h,
                                    colorFilter:
                                        ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                                  ),
                                ),
                                SizedBox(width: 1.w),
                                Visibility(
                                  visible: selectedItem.distance == 0.0 ? false : true,
                                  child: Text(
                                    '${selectedItem.distance} km',
                                    style: AppTypography.detail,
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          const Text(
                            "Description",
                            style: AppTypography.title02,
                          ),
                          SizedBox(height: 2.h),
                          // Display the property description.
                          Text(
                            selectedItem.description,
                            style: AppTypography.body,
                          ),
                          SizedBox(height: 2.h),
                          const Text(
                            "Location",
                            style: AppTypography.title02,
                          ),
                          SizedBox(height: 2.h),
                          SizedBox(
                            height: 34.h,
                            child: GoogleMap(
                              // Display the property location on a map.
                              initialCameraPosition: CameraPosition(
                                target: LatLng(selectedItem.latitude.toDouble(),
                                    selectedItem.longitude.toDouble()),
                                zoom: 12,
                              ),
                              zoomControlsEnabled: false,
                              mapToolbarEnabled: false,
                              markers: {
                                // Place a marker at the property location.
                                Marker(
                                    markerId: const MarkerId(Strings.mapsLocationId),
                                    position: LatLng(selectedItem.latitude.toDouble(),
                                        selectedItem.longitude.toDouble()),
                                    infoWindow: const InfoWindow(title: Strings.mapsText),
                                    onTap: () {
                                      launchMapsApp(selectedItem.latitude.toDouble(),
                                          selectedItem.longitude.toDouble());
                                    }),
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
