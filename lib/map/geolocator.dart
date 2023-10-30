import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';

Future<LatLng> getCurrentLatLng() async {
  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    // Handle case where the user denied access to their location
  }

  final data = await Geolocator.getCurrentPosition();
  return LatLng(data.latitude, data.longitude);
}
