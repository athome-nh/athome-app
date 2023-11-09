import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/main.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/map/geolocator.dart';
import 'package:athome/map/locationdeatil.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class Map_screen extends StatefulWidget {
  const Map_screen({super.key});

  @override
  State<Map_screen> createState() => _Map_screenState();
}

class _Map_screenState extends State<Map_screen> {
  @override
  void initState() {
    getCureentlocation();
    scrollTimer = Timer(const Duration(milliseconds: 0), () {});
    super.initState();
  }

  late Timer? scrollTimer;

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

  PolygonAnnotation? polygonAnnotation;
  PolygonAnnotationManager? polygonAnnotationManager;
  int styleIndex = 1;
  late MapboxMap _mapController;
  String nameloc = "";
  String housenumber = "";
  double selectLat = 0.0;
  double selectLon = 0.0;
  bool wait = false;
  bool zoom = false;
  _onMapCreated(MapboxMap mapboxMap) {
    _mapController = mapboxMap;
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
      appBar: AppBar(
        title: Text(
          "Map".tr,
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: mainColorWhite,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColorRed,
            )),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            MapWidget(
                key: const ValueKey("mapWidget"),
                onCameraChangeListener: (cameraChangedEventData) {
                  setState(() {
                    wait = true;
                  });
                  if (scrollTimer != null) {
                    scrollTimer!.cancel();
                  }
                  scrollTimer = Timer(const Duration(milliseconds: 500), () {
                    _mapController.getCameraState().then((value) {
                      final split = value.center["coordinates"]
                          .toString()
                          .substring(1)
                          .replaceAll("]", '')
                          .split(",");

                      if (isPointInsidePolygon(
                          Position(
                              double.parse(split[0]), double.parse(split[1])),
                          zone)) {
                        if (value.zoom < 12) {
                          setState(() {
                            zoom = true;
                            nameloc = "Zoom in Please".tr;
                            wait = false;
                          });
                        } else {
                          getLocationName(
                              double.parse(split[0]), double.parse(split[1]));
                        }
                      } else {
                        setState(() {
                          zoom = true;
                          nameloc = "Sorry, we don't deliver here".tr;
                          wait = false;
                        });
                      }
                    });
                  });
                },
                resourceOptions:
                    ResourceOptions(accessToken: MAPBOX_ACCESS_TOKEN),
                onMapCreated: _onMapCreated),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/PIN@2x.png",
                  width: 65,
                  height: 65,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120, right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: mainColorLightGrey),
                  child: IconButton(
                    onPressed: () async {
                      await getCureentlocation(); // Our guy 😄
                    },
                    icon: Icon(FontAwesomeIcons.locationCrosshairs,
                        size: 25, color: mainColorRed),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: getWidth(context, 100),
                    height: getHeight(context, 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                        color: zoom ? mainColorRed : Colors.green),
                    child: Center(
                        child: wait
                            ? Container(
                                height: getWidth(context, 10),
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballRotateChase,
                                  colors: [
                                    mainColorWhite,
                                    // mainColorRed,
                                    // mainColorSuger,
                                  ],

                                  // strokeWidth: 5,
                                ),
                              )
                            : GestureDetector(
                                onTap: zoom
                                    ? null
                                    : () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                location_Deatil(
                                                    selectLon,
                                                    selectLat,
                                                    nameloc,
                                                    housenumber),
                                          ),
                                        );
                                      },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    zoom
                                        ? const SizedBox()
                                        : Text(
                                            "Delivery To:".tr,
                                            style: TextStyle(
                                                color: mainColorWhite,
                                                fontSize: 16),
                                          ),
                                    zoom
                                        ? const SizedBox()
                                        : const SizedBox(
                                            width: 3,
                                          ),
                                    Text(
                                      nameloc,
                                      style: TextStyle(
                                          color: mainColorWhite, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ))),
              ),
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
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng&accept-language=$lang';

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    httpClient.close();
    if (response.statusCode == 200) {
      var data = json.decode(responseBody);
      setState(() {
        String check = data.toString();
        nameloc = check.contains('neighbourhood')
            ? data["address"]["neighbourhood"]
            : check.contains('village')
                ? data["address"]["village"]
                : textCount(data["display_name"], 25);

        housenumber = check.contains('house_number')
            ? data["address"]["house_number"]
            : "";
        selectLat = lat;
        selectLon = lng;
        wait = false;
        zoom = false;
      });
    } else {
      setState(() {
        nameloc = "try again".tr;
        wait = false;
      });
      throw Exception('Failed to load data'.tr);
    }
  }

  Future<void> getCureentlocation() async {
    final myLocationData = await getCurrentLatLng();

    getLocationName(myLocationData.longitude, myLocationData.latitude);
    _mapController.flyTo(
        CameraOptions(
            center: Point(
                    coordinates: Position(
                        myLocationData.longitude, myLocationData.latitude))
                .toJson(),
            zoom: 18,
            bearing: 0,
            pitch: 15),
        MapAnimationOptions(duration: 2000, startDelay: 0));

    setState(() {});
  }
}
