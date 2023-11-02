// import 'dart:async';
// import 'dart:collection';
// import 'package:athome/Config/property.dart';
// import 'package:athome/landing/login_page.dart';
// import 'package:athome/map/locationdeatil.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:math';

// class Maps_screen extends StatefulWidget {
//   const Maps_screen({super.key});

//   @override
//   State<Maps_screen> createState() => _Maps_screenState();
// }

// class _Maps_screenState extends State<Maps_screen> {
//   static LatLng _googleLngLat = LatLng(36.19132291385898, 44.00944021193411);
//   late LatLng _selectedLocation;

//   Set<Marker> _markers = {};
//   List<LatLng> coordinates = [
//     LatLng(36.199605563766106, 43.97992179909366),
//     LatLng(36.19362632444889, 43.97670629415453),
//     LatLng(36.18635234169956, 43.97447766399814),
//     LatLng(36.183026992105354, 43.97483914728845),
//     LatLng(36.1843077267883, 43.98288520837741),
//     LatLng(36.18552548228508, 43.986018556321405),
//     LatLng(36.19055214575381, 43.993175484622846),
//     LatLng(36.19517303825584, 43.99367879334041),

//     // Add all your coordinates here
//     // Add more coordinates as needed
//   ];
//   // late GoogleMapController _controller;
//   late Completer<GoogleMapController> _controller = Completer();
//   late GoogleMapController _controller2;

//   Set<Circle> _circle = HashSet<Circle>();
//   Set<Polygon> _polygon = HashSet<Polygon>();

//   @override
//   void initState() {
//     super.initState();

//     _polygon.add(Polygon(
//       polygonId: PolygonId('2'),
//       points: coordinates,
//       strokeWidth: 2,
//       fillColor: Colors.red.withOpacity(0.2),
//       strokeColor: Colors.yellow,
//     ));
//     _circle.add(
//       Circle(
//         circleId: CircleId("1"),
//         onTap: () {},
//         radius: 10000.6,
//         center: _googleLngLat,
//         strokeWidth: 2,
//         fillColor: Colors.green.withOpacity(0.2),
//         strokeColor: Colors.green,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Map",
//           style: TextStyle(
//               color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
//         ),
//         centerTitle: true,
//         backgroundColor: mainColorWhite,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: mainColorRed,
//             )),
//       ),
//       body: Container(
//         height: getHeight(context, 100),
//         width: getWidth(context, 100),
//         child: Stack(
//           children: [
//             GoogleMap(
//               mapType: MapType.normal,
//               myLocationButtonEnabled: false,
//               myLocationEnabled: true,
//               zoomControlsEnabled: false,
//               circles: _circle,
//               polygons: _polygon,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//                 _controller2 = controller;
//               },
//               initialCameraPosition: CameraPosition(
//                 target:
//                     _googleLngLat, // Set the initial camera position to the first coordinate
//                 zoom: 15.0, // You can adjust the initial zoom level as needed
//               ),
//               markers: _markers,
//               onTap: (LatLng location) {
//                 setState(() {
//                   _selectedLocation = location;
//                   _markers.clear();
//                   _markers.add(
//                     Marker(
//                       markerId: const MarkerId('Selected Location'),
//                       position: location,
//                     ),
//                   );
//                   // LatLng point1 = LatLng(36.188372277087595, 43.97223721537533);
//                   // LatLng point2 = LatLng(36.19089314288302, 44.00893646913687);

//                   // double distance1 = LatLngUtils.calculateDistance(point1, point2);

//                   //     print('Distance between point1 and point2: $distance1 km');

//                   double distance = calculateDistance(
//                       location.latitude, location.longitude, _googleLngLat);
//                   double circleRadius =
//                       10000.0; // Radius of the circle in meters

//                   if (distance <= circleRadius) {
//                     LatLng locationToCheck = _selectedLocation;

//                     bool isInsidePolygon =
//                         _isLocationInsidePolygon(locationToCheck);
//                     print('Is Inside Polygon: $isInsidePolygon');
//                   } else {
//                     _markers.clear();
//                     AwesomeDialog(
//                             context: context,
//                             animType: AnimType.scale,
//                             dialogType: DialogType.info,
//                             showCloseIcon: true,
//                             title: "Unavailable location",
//                             desc: "Sorry unavailable now from your location",
//                             btnOkColor: mainColorRed,
//                             btnOkText: "Ok",
//                             btnOkOnPress: () {},
//                             btnCancelColor: mainColorGrey)
//                         .show();
//                     // The location is outside the circle
//                     // You can add your logic here
//                     print('Location is outside the circle');
//                   }
//                 });
//               },
//             ),
//             Positioned(
//               bottom: getHeight(context,
//                   40), // Adjust the position of the button from the bottom
//               right: 16.0, // Adjust the position of the button from the left
//               child: Container(
//                 // margin: EdgeInsets.only(
//                 //     top: getHeight(context, 40), left: getWidth(context, 85)),
//                 child: Column(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         getCurrentLocation();
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.white),
//                         height: 50,
//                         width: 50,
//                         child: Icon(Icons.my_location, color: mainColorGrey),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _controller2.animateCamera(CameraUpdate.zoomIn());
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.white),
//                         height: 50,
//                         width: 50,
//                         child: Icon(Icons.add, color: mainColorGrey),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         _controller2.animateCamera(CameraUpdate.zoomOut());
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             color: Colors.white),
//                         height: 50,
//                         width: 50,
//                         child: Icon(Icons.remove, color: mainColorGrey),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             _markers.isEmpty
//                 ? Positioned(
//                     bottom: 16,
//                     right: getWidth(context, 10),
//                     child: Container(
//                       height: getHeight(context, 5),
//                       width: getWidth(context, 80),
//                       decoration: BoxDecoration(color: mainColorGrey),
//                       child: Center(
//                           child: Text(
//                         "Tap to select location",
//                         style: TextStyle(
//                             color: mainColorWhite,
//                             fontSize: 18,
//                             fontFamily: mainFontnormal),
//                       )),
//                     ),
//                   )
//                 : Positioned(
//                     bottom: 16,
//                     right: getWidth(context, 10),
//                     child: SizedBox(
//                       height: getHeight(context, 5),
//                       width: getWidth(context, 80),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => location_Deatil(
//                                     _selectedLocation.longitude,
//                                     _selectedLocation.latitude)),
//                           );
//                         },
//                         style: ButtonStyle(
//                           backgroundColor:
//                               MaterialStateProperty.all<Color>(mainColorRed),
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                           ),
//                         ),
//                         child: Text(
//                           'Select Location',
//                           style: TextStyle(
//                               color: mainColorWhite,
//                               fontSize: 20,
//                               fontFamily: mainFontnormal),
//                         ),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }

//   bool _isLocationInsidePolygon(LatLng location) {
//     if (_controller != null) {
//       return isPointInsidePolygon(location, coordinates);
//     }
//     return false;
//   }

//   bool isPointInsidePolygon(LatLng point, List<LatLng> polygon) {
//     int crossings = 0;
//     for (int i = 0; i < polygon.length; i++) {
//       LatLng currentPoint = polygon[i];
//       LatLng nextPoint = polygon[(i + 1) % polygon.length];
//       if (point.latitude >= min(currentPoint.latitude, nextPoint.latitude) &&
//           point.latitude < max(currentPoint.latitude, nextPoint.latitude) &&
//           point.longitude < max(currentPoint.longitude, nextPoint.longitude) &&
//           currentPoint.latitude != nextPoint.latitude) {
//         double x = currentPoint.longitude +
//             (point.latitude - currentPoint.latitude) /
//                 (nextPoint.latitude - currentPoint.latitude) *
//                 (nextPoint.longitude - currentPoint.longitude);
//         if (currentPoint.longitude == nextPoint.longitude ||
//             point.longitude <= x) {
//           crossings++;
//         }
//       }
//     }
//     return crossings % 2 != 0;
//   }

//   double calculateDistance(double lat1, double lon1, LatLng latLng2) {
//     final double earthRadius = 6371000; // Radius of the Earth in meters
//     final double dLat = radians(latLng2.latitude - lat1);
//     final double dLon = radians(latLng2.longitude - lon1);
//     final double a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(radians(lat1)) *
//             cos(radians(latLng2.latitude)) *
//             sin(dLon / 2) *
//             sin(dLon / 2);
//     final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return earthRadius * c;
//   }

//   double radians(double degrees) {
//     return degrees * pi / 180;
//   }

//   Future<void> getCurrentLocation() async {
//     try {
//       // Request permission to access the device's location
//       LocationPermission permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         // Handle case where the user denied access to their location
//         return;
//       }

//       // Get the current position (latitude and longitude)
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy
//             .bestForNavigation, // You can adjust the desired accuracy
//       );

//       // Access the latitude and longitude from the position

//       setState(() {
//         _selectedLocation = LatLng(position.latitude, position.longitude);
//         _controller2.animateCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: _selectedLocation,
//               zoom: 190.0,
//             ),
//           ),
//         );

//         _googleLngLat = _selectedLocation;
//         _markers.clear();
//         _markers.add(
//           Marker(
//             markerId: const MarkerId('Selected Location'),
//             position: _selectedLocation,
//           ),
//         );
//       });
//     } catch (e) {
//       // Handle any errors that occur during the process
//       print("Error: $e");
//     }
//   }
// }
