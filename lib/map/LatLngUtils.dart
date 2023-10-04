import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class LatLngUtils {
  static const double earthRadius = 6371; // Earth's radius in kilometers

  static double calculateDistance(LatLng start, LatLng end) {
    // Convert latitude and longitude from degrees to radians
    double startLatRadians = degreesToRadians(start.latitude);
    double startLngRadians = degreesToRadians(start.longitude);
    double endLatRadians = degreesToRadians(end.latitude);
    double endLngRadians = degreesToRadians(end.longitude);

    // Calculate the differences between the two points
    double latDiff = endLatRadians - startLatRadians;
    double lngDiff = endLngRadians - startLngRadians;

    // Calculate the Haversine distance
    double a = pow(sin(latDiff / 2), 2) +
        cos(startLatRadians) * cos(endLatRadians) * pow(sin(lngDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  static double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }






  
}