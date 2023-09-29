import 'dart:math';

import 'package:geolocator/geolocator.dart';

class Helper {
  static Position? currentLocation;

  static Future<double> calculateDistance(double houseLatitude, double houseLongitude) async {
    // Get the current location if permission is allowed
    if (currentLocation == null) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        currentLocation =
            await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
    }

    // Return 0 if current location is still not found
    if (currentLocation == null) return 0;

    // Extract latitude and longitude values
    double lat1 = currentLocation!.latitude;
    double lon1 = currentLocation!.longitude;
    double lat2 = houseLatitude;
    double lon2 = houseLongitude;

    // Radius of the Earth in kilometers
    const double earthRadius = 6371;

    // Calculate the differences in latitude and longitude in radians
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    // Use the Haversine formula to calculate the distance
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance in kilometers
    double distance = earthRadius * c;

    return distance;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
