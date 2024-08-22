import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLatLng() async {
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied) {
  }
  Position data = await Geolocator.getCurrentPosition();
  return data;
}
