import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/search/views/search_view.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:shimmer/shimmer.dart';

class ExploreAppBarWidget extends StatefulWidget {
  const ExploreAppBarWidget({Key? key}) : super(key: key);

  @override
  State<ExploreAppBarWidget> createState() => _ExploreAppBarWidgetState();
}

class _ExploreAppBarWidgetState extends State<ExploreAppBarWidget> {
  bool finding = true;
  bool errorPermission = false;
  String locationText = "-";
  int dotCount = 0;

  @override
  void initState() {
    lookingAddress();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void lookingAddress() async {
    if (errorPermission) {
      await showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text(
            "Informasi",
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: "Google-Sans",
            ),
          ),
          content: const Text(
            "Silahkan lakukan pengaturan untuk memberikan izin kepada ISSI Mobile agar dapat mengetahui informasi lokasi anda saat ini.",
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: "Google-Sans",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text(
                "Nanti",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Google-Sans",
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
                await Geolocator.openLocationSettings();
              },
              child: const Text(
                "Pengaturan",
                style: TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Google-Sans",
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      finding = true;
      getGeoLocationPosition();
    }
  }

  Future<void> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      finding = false;
      errorPermission = true;
      setState(() {
        locationText = "Tidak diizinkan";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        finding = false;
        errorPermission = true;
        setState(() {
          locationText = "Tidak diizinkan";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      finding = false;
      errorPermission = true;
      setState(() {
        locationText = "Tidak diizinkan";
      });
      return;
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    getAddressFromLatLong(position);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude /* , localeIdentifier: 'id_ID' */);
    Placemark place = placemarks[0];
    finding = false;
    setState(() {
      locationText = (place.subLocality != '' ? '${place.subLocality}, ${place.locality}' : place.locality)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: const Color(0xFF111111),
      floating: false,
      pinned: true,
      expandedHeight: 110.0,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(120),
          bottomRight: Radius.circular(120),
        ),
      ),
      title: BouncingButtonHelper(
        color: Colors.transparent,
        width: mediaSize.width,
        autoHeight: true,
        onTap: () {
          lookingAddress();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Your Location',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: "Google-Sans",
              ),
            ),
            finding
                ? Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[700]!,
                      highlightColor: Colors.grey[900]!,
                      child: Container(
                        height: 14,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  )
                : Text(
                    locationText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: "Google-Sans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ],
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: mediaSize.width - 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 14.0),
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: const Image(
                              image: AssetImage(
                                'assets/images/icons/search.png',
                              ),
                              width: 20.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: SizedBox(
                              width: mediaSize.width - 130,
                              height: 32,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                  primary: Colors.transparent,
                                  padding: const EdgeInsets.all(0),
                                ),
                                onPressed: () {
                                  Get.to(
                                    const SearchView(),
                                    transition: Transition.fadeIn,
                                    duration: const Duration(milliseconds: 400),
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        "Search...",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 22.0,
                                          fontFamily: "Google-Sans",
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
