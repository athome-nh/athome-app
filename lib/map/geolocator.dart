import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLatLng() async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
    // Handle case where the user denied access to their location
  }
  Position data = await Geolocator.getCurrentPosition();
  return data;
}
