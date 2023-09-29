import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_real_estate/models/house_model.dart';
import 'package:flutter_real_estate/ui/components/top_app_bar.dart';
import 'package:flutter_real_estate/ui/theme/type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/constants.dart';
import '../theme/colors.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.selectedItem}) : super(key: key);

  final HouseData selectedItem;

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailScreen> {
  bool screenOpen = true;

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
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: widget.selectedItem.id,
                  child: SizedBox(
                    child: CachedNetworkImage(
                      imageUrl: Constants.baseAPIUrl + widget.selectedItem.image,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.w, right: 6.w, top: 6.h, bottom: 1.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Text(
                                // Regular Expression for put commas to the amount of money
                                '\$${widget.selectedItem.price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: AppTypography.title01,
                              )),
                              // SizedBox(width: 1.w),
                              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                SvgPicture.asset(
                                  'assets/icons/ic_bed.svg',
                                  width: 2.h,
                                  height: 2.h,
                                  colorFilter: ColorFilter.mode(AppColors.medium, BlendMode.srcIn),
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  widget.selectedItem.bedrooms.toString(),
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
                                  widget.selectedItem.bathrooms.toString(),
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
                                  widget.selectedItem.size.toString(),
                                  style: AppTypography.detail,
                                ),
                                SizedBox(width: 4.w),
                                Visibility(
                                  visible: widget.selectedItem.distance == 0.0 ? false : true,
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
                                  visible: widget.selectedItem.distance == 0.0 ? false : true,
                                  child: Text(
                                    '${widget.selectedItem.distance} km',
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
                          Text(
                            widget.selectedItem.description,
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
                            child: Visibility(
                              visible: screenOpen,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(widget.selectedItem.latitude.toDouble(),
                                      widget.selectedItem.longitude.toDouble()),
                                  zoom: 12,
                                ),
                                markers: {
                                  Marker(
                                      markerId: const MarkerId('targetMarker'),
                                      position: LatLng(widget.selectedItem.latitude.toDouble(),
                                          widget.selectedItem.longitude.toDouble()),
                                      infoWindow: const InfoWindow(title: 'Location of house'),
                                      onTap: () {
                                        launchMapsApp(widget.selectedItem.latitude.toDouble(),
                                            widget.selectedItem.longitude.toDouble());
                                      }),
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
