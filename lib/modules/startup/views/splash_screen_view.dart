import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/modules/home/views/dashboard_view.dart';
import 'package:mobile/modules/startup/views/onboarding_view.dart';
import 'package:mobile/utils/networks/key_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:shimmer/shimmer.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  GetStorage localData = GetStorage();
  bool _isShowOnboard = true;

  String copyright = '';

  @override
  void initState() {
    getVersion();
    _isShowOnboard = localData.read(KeyStorage.isOnboarded) == null ? true : false;
    super.initState();
  }

  void startTime() async {
    Timer(const Duration(milliseconds: 2000), () {
      Get.offAll(
        _isShowOnboard ? const OnboardingView() : const DashboardView(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 400),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text(
              "Konfirmasi",
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Google-Sans",
              ),
            ),
            content: const Text(
              "Apakah anda yakin akan menutup aplikasi?",
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: "Google-Sans",
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Tidak",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Google-Sans",
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Ya",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "Google-Sans",
                  ),
                ),
              ),
            ],
          ),
        )) ??
        false;
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      copyright = "$appName v$version build $buildNumber";
    });

    startTime();
  }

  @override
  Widget build(BuildContext context) {
    var mediaPadding = MediaQuery.of(context).padding;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        body: Stack(
          children: [
            /* Positioned(
              width: mediaSize.width,
              bottom: 0,
              child: const Center(
                child: Image(
                  image: AssetImage(
                    'assets/images/cycling.gif',
                  ),
                ),
              ),
            ), */
            Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        Get.isDarkMode ? 'assets/images/logo_full_light.png' : 'assets/images/logo_full.png',
                      ),
                      width: 220.0,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: CupertinoActivityIndicator(
                    radius: 10,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: mediaPadding.bottom + 6),
                  child: copyright == ""
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 160,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2.0),
                              color: Colors.grey[700],
                            ),
                          ),
                        )
                      : Text(
                          copyright,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFF888888),
                            fontFamily: "Google-Sans",
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
