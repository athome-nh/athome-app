import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:athome/Config/value.dart';
import 'package:athome/map/geolocator.dart';
import 'package:athome/map/marker.dart';
import 'package:athome/map/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Map_screen extends StatefulWidget {
  const Map_screen({super.key});

  @override
  State<Map_screen> createState() => _Map_screenState();
}

class _Map_screenState extends State<Map_screen> {
  @override
  void initState() {
    addMarker();

    super.initState();
  }

  List<Position> zone = [
    Position(44.15648043186607, 36.214125941590865),
    Position(44.14672249711742, 36.235431148421),
    Position(44.13948718068954, 36.23834016892215),
    Position(44.13714155654944, 36.23306560827915),
    Position(44.138207749339955, 36.22521044002244),
    Position(44.134298375772175, 36.223432883722836),
    Position(44.1267639467132, 36.22102451719711),
    Position(44.12629301848048, 36.22455783720254),
    Position(44.12845922335518, 36.226708568052175),
    Position(44.125584836118634, 36.23184991928622),
    Position(44.12183563537516, 36.23084183784269),
    Position(44.092434976661025, 36.22094000058391),
    Position(44.08362773956341, 36.22847544440586),
    Position(44.08149265178295, 36.23601016220252),
    Position(44.09274407980601, 36.2412910678498),
    Position(44.10268466528157, 36.24384202504726),
    Position(44.10912345360049, 36.24908033682375),
    Position(44.10634635128352, 36.253909425195985),
    Position(44.09829637678877, 36.26097766434722),
    Position(44.103488048014924, 36.266221039090055),
    Position(44.10363567002594, 36.2710215365384),
    Position(44.098911765689195, 36.273362167930514),
    Position(44.11988784489688, 36.289276408441),
    Position(44.134735818609215, 36.2905125349525),
    Position(44.15097796825776, 36.294445534475656),
    Position(44.15509078726731, 36.2984906985684),
    Position(44.16450147483175, 36.30585011186312),
    Position(44.1740515799892, 36.301018819604394),
    Position(44.18502545763067, 36.304910170880575),
    Position(44.18534131499206, 36.30783735301745),
    Position(44.17649730888783, 36.31292784283849),
    Position(44.17033809034979, 36.31509120037114),
    Position(44.16115687618881, 36.317720647278904),
    Position(44.156172669536886, 36.31838997778965),
    Position(44.14895195989979, 36.31890484350188),
    Position(44.14090054915306, 36.312983682483065),
    Position(44.13406324002773, 36.308709869440165),
    Position(44.124669927490686, 36.29995554518379),
    Position(44.10929554444152, 36.28661064429683),
    Position(44.107696841886366, 36.286903521189146),
    Position(44.10384542209542, 36.287635708610395),
    Position(44.098504302195806, 36.287459984255804),
    Position(44.094616548255914, 36.28871933338664),
    Position(44.08873041612213, 36.29141368652013),
    Position(44.08506066707679, 36.28643491763397),
    Position(44.08110024483929, 36.287459984255804),
    Position(44.08040989600826, 36.28892434178648),
    Position(44.077321493346005, 36.28918792322324),
    Position(44.07383341504493, 36.288016443354365),
    Position(44.07299772961852, 36.288280027858505),
    Position(44.071835036850985, 36.28596631126548),
    Position(44.06103868618209, 36.28964910853864),
    Position(44.06329891941013, 36.29444704159398),
    Position(44.047184688537214, 36.29921572738549),
    Position(44.05081087527239, 36.33236500770012),
    Position(44.0261621793137, 36.33071025386428),
    Position(43.999552791631174, 36.28993203932491),
    Position(44.01239475711367, 36.290090801134966),
    Position(44.016748578056024, 36.28969100494038),
    Position(44.01440249413787, 36.26437734903433),
    Position(43.98142884631582, 36.26593837721768),
    Position(43.98025929483231, 36.233710467688454),
    Position(43.95437764577676, 36.20988799280086),
    Position(43.93057888105005, 36.213862298954496),
    Position(43.92517446270696, 36.1938416360741),
    Position(43.932056919561376, 36.16309796991378),
    Position(43.979439352317, 36.14162569504654),
    Position(43.998205607360916, 36.11075538045098),
    Position(44.02086576976856, 36.10469023131036),
    Position(44.02087551718856, 36.101444215192444),
    Position(44.05412066405259, 36.09231874117789),
    Position(44.086433622564215, 36.10214664226582),
    Position(44.094956243197174, 36.11973046655281),
    Position(44.07738653296843, 36.12534374998327),
    Position(44.07798447484319, 36.13296135251275),
    Position(44.08204086331904, 36.13647142977116),
    Position(44.089632104608995, 36.14166605596732),
    Position(44.11078327308962, 36.13272734177964),
    Position(44.13314060960437, 36.14308001602596),
    Position(44.14373610157804, 36.16100786949015),
    Position(44.15248146620621, 36.16878619394386),
    Position(44.145719643549455, 36.17595294132525),
    Position(44.15639726467779, 36.21423817661292),
  ];
  MapboxMap? mapboxMap;
  PolygonAnnotation? polygonAnnotation;
  PolygonAnnotationManager? polygonAnnotationManager;
  int styleIndex = 1;
  late MapboxMap _mapController;
  final markerList = <Marker>{};
  // String MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoiYXRob21lYXBwIiwiYSI6ImNsbnVhaWhuczBlZXEycW5zcTlvMm9qcGgifQ.7hy4D3JXCWvFQXVTg33bHA';
  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    _mapController = mapboxMap;
    // We tell the controller to show the user location on the map
    _mapController.location.updateSettings(
        LocationComponentSettings(enabled: true, pulsingEnabled: true));
    mapboxMap.annotations.createPolygonAnnotationManager().then((value) {
      polygonAnnotationManager = value;

      var options = <PolygonAnnotationOptions>[];

      options.add(PolygonAnnotationOptions(
          geometry: Polygon(coordinates: [zone]).toJson(),
          fillColor: Colors.green.value,
          fillOpacity: 0.2));

      polygonAnnotationManager?.createMulti(options);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MapWidget(
                onTapListener: (coordinate) {
                  if (isPointInsidePolygon(
                      Position(coordinate.y, coordinate.x), zone)) {
                    // getLocationName(coordinate.y, coordinate.x);
                    print("jegr");
                  } else {
                    print("hunar");
                  }
                },
                key: ValueKey("mapWidget"),
                onScrollListener: (coordinate) {
                  //  print("objectscrool");
                },
                resourceOptions:
                    ResourceOptions(accessToken: MAPBOX_ACCESS_TOKEN),
                onMapCreated: _onMapCreated),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
                child: Icon(Icons.swap_horiz),
                onPressed: () {
                  mapboxMap?.style.setStyleURI(
                      annotationStyles[++styleIndex % annotationStyles.length]);
                }),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () async {
                await addMarker(); // Our guy 😄
              },
              child: const Icon(FontAwesomeIcons.locationCrosshairs),
            ),
          ],
        ),
      ),
    );
  }

  bool isPointInsidePolygon(Position point, List<Position> polygon) {
    int crossings = 0;
    for (int i = 0; i < polygon.length; i++) {
      Position currentPoint = polygon[i];
      Position nextPoint = polygon[(i + 1) % polygon.length];

      if (point.lat >= min(currentPoint.lat, nextPoint.lat) &&
          point.lat < max(currentPoint.lat, nextPoint.lat) &&
          point.lng < max(currentPoint.lng, nextPoint.lng) &&
          currentPoint.lat != nextPoint.lat) {
        double x = currentPoint.lng +
            (point.lat - currentPoint.lat) /
                (nextPoint.lat - currentPoint.lat) *
                (nextPoint.lng - currentPoint.lng);
        if (currentPoint.lng == nextPoint.lng || point.lng <= x) {
          crossings++;
        }
      }
    }
    return crossings % 2 != 0;
  }

  Future<void> getLocationName(double lng, double lat) async {
    final url =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${lng},${lat}.json?access_token=$MAPBOX_ACCESS_TOKEN';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          //  print(data['features']);
          print(data['features'][0]['place_name']);
          print(data['features'][0]['address']);
          print(data['features'][0]['text']);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  getstreet(double lat, double lng) async {
    await placemarkFromCoordinates(lng, lat).then((List<Placemark> placemarks) {
      placemarks.forEach((element) {
        if (element.thoroughfare!.isNotEmpty) {
          print(element);
        } else {}
      });
      Placemark place = placemarks[0];
      // setState(() {
      //   print('${place.street}, ${place.subLocality}'
      //       '${place.subAdministrativeArea}'
      //       ' ${place.postalCode}');
      // });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> addMarker() async {
    // We get our current location data
    final myLocationData = await getCurrentLatLng();
    _mapController?.easeTo(
        CameraOptions(
            center: Point(
                    coordinates: Position(
                        myLocationData.longitude, myLocationData.latitude))
                .toJson(),
            zoom: 19,
            bearing: 0,
            pitch: 15),
        MapAnimationOptions(duration: 2000, startDelay: 0));

    setState(() {});
  }
}
