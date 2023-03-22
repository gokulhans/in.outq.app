import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/screens/user/location/osm/osm_location_show.dart';
import 'package:outq/utils/color_constants.dart';
import 'package:outq/utils/constants.dart';
import 'package:outq/utils/widget_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart' as latLng;

String userlocation = "loading...";
String userlongitude = "0.0";
String userlatitude = "0.0";
String? userpincode;
double userlat = 0.0;
double userlong = 0.0;
bool isVisible = false;

Future updateuser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userid = prefs.getString("userid") ?? "null";
  // String deviceid = "";

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // messaging.getToken().then((token) {
  //   deviceid = token!;
  // });

  http.post(
      Uri.parse(
        "${apidomain}auth/user/update/$userid",
      ),
      headers: <String, String>{
        'Context-Type': 'application/json; charset=UTF-8',
      },
      body: <String, String>{
        'location': userlocation ?? "",
        'pincode': userpincode ?? "",
        'longitude': userlongitude ?? "",
        'latitude': userlatitude ?? "",
        // 'deviceid': deviceid
      });

  // if (response.statusCode == 201) {
  //   var jsonData = jsonDecode(response.body);
  //   // print(jsonData);
  //   // print(jsonData["success"]);
  //   if (jsonData["success"]) {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (BuildContext context) => OwnerExithome()),
  //         (Route<dynamic> route) => false);
  //   }
  // }
}

class GetLocationPage extends StatefulWidget {
  const GetLocationPage({super.key});

  @override
  State<GetLocationPage> createState() => _GetLocationPageState();
}

class _GetLocationPageState extends State<GetLocationPage> {
  String _currentAddress = "";
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('Location permissions are denied. Enable to Continue')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    _getCurrentPosition();
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      Geolocator.openLocationSettings();
    }
    // return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        userlat = position.latitude;
        userlong = position.longitude;
      });
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      print(place);
      setState(() {
        _currentAddress =
            '${place.administrativeArea}, ${place.locality}, ${place.thoroughfare}, ${place.postalCode}';
      });
      print({_currentAddress, _currentPosition});
      userlocation = _currentAddress;
      userlongitude = _currentPosition!.longitude.toString();
      userlatitude = _currentPosition!.latitude.toString();
      userpincode = place.postalCode.toString();
      print({userlocation, userlongitude, userlatitude, userpincode});
      // updateuser(context);
      setState(() {
        userlocation = _currentAddress;
        userlat = _currentPosition!.latitude;
        userlong = _currentPosition!.longitude;
        isVisible = true;
      });
      print({userlat, userlong});
      // print(isVisible);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  // void checklocationisSaved() async {
  //   var locuserid;
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   locuserid = pref.getString("userid");
  //   final response =
  //       await http.get(Uri.parse('${apidomain}auth/user/location/$locuserid'));
  //   var jsonData = jsonDecode(response.body);
  //   if (jsonData[0]["location"] == null) {
  //     _getCurrentPosition();
  //   }
  // }

  @override
  void initState() {
    // checklocationisSaved();
    _handleLocationPermission();
    _getCurrentPosition();
    super.initState();
  }

  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     body: Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         Center(
      //           child: Text(
      //             "${userlocation}",
      //             style: TextStyle(color: Colors.black),
      //           ),
      //         ),
      //         isVisible
      //             ? TextButton(
      //                 onPressed: () {
      //                   Get.to(() => ShowLocationMap(
      //                         lat: userlat,
      //                         long: userlat,
      //                       ));
      //                 },
      //                 child: const Text("Give Permission Location"))
      //             : const Text("Loading")
      //       ],
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Image(
                    image: AssetImage(
                  "assets/images/location.png",
                )),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Location Access",
                    style: GoogleFonts.montserrat(
                        color: ColorConstants.appbgclr2,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "We use device location to show you near by shops",
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Center(
                  child: Container(
                    // width: 250,
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 50,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: ColorConstants.appbgclr2),
                    child: Center(
                      child: TextButton(
                        onPressed: isVisible
                            ? () {
                                Get.to(
                                  () => ShowLocationMap(
                                    lat: double.parse(userlatitude),
                                    long: double.parse(userlongitude),
                                  ),
                                );
                              }
                            : null,
                        child: isVisible
                            ? Text(
                                "Continue",
                                style: Theme.of(context).textTheme.headline6,
                              )
                            : Text(
                                "Fetching...",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(10)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
