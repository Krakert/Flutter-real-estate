import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final locationPermissionProvider = FutureProvider<bool>((ref) async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return false;
  }
  // Check if location permission denied forever
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return false;
  }

  switch (permission) {
    case LocationPermission.denied:
      var retry = await Geolocator.requestPermission();
      if (retry == LocationPermission.whileInUse || retry == LocationPermission.always) {
        return true;
      }
    case LocationPermission.deniedForever:
      return false;
    case LocationPermission.whileInUse:
      return true;
    case LocationPermission.always:
      return true;
    case LocationPermission.unableToDetermine:
      return false;
  }
  return false;
});
