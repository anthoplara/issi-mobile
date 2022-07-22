import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/modules/home/views/dashboard_view.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';
import 'package:mobile/utils/networks/key_storage.dart';
import 'package:override_text_scale_factor/override_text_scale_factor.dart';
import 'package:package_info/package_info.dart';
import 'package:shimmer/shimmer.dart';

import 'login_view.dart';
import 'onboarding_view.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({Key? key}) : super(key: key);

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  GetStorage localData = GetStorage();
  bool _isShowOnboard = true;
  bool _isLogged = false;

  String copyright = '';

  @override
  void initState() {
    getVersion();
    _isShowOnboard = (localData.read(KeyStorage.isOnboarded) ?? "") == "" ? true : false;
    _isLogged = (localData.read(KeyStorage.userId) ?? "0") == "0" ? false : true;
    super.initState();
  }

  void startTime() async {
    Timer(const Duration(milliseconds: 2000), () {
      Get.offAll(
        _isShowOnboard ? const OnboardingView() : (_isLogged ? const DashboardView() : const LoginView()),
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
          builder: (context) => OverrideTextScaleFactor(
            textScaleFactor: ConstantConfig().textScale,
            child: CupertinoAlertDialog(
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
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: OverrideTextScaleFactor(
        textScaleFactor: ConstantConfig().textScale,
        child: Scaffold(
          body: Stack(
            children: [
              ConstantConfig().background,
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    image: const AssetImage(
                      'assets/images/splashscreen.png',
                    ),
                    width: mediaSize.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 100,
                    color: const Color(0xff23232d),
                  ),
                ],
              ),
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Image(
                        image: AssetImage(
                          'assets/images/logo_full.png',
                        ),
                        width: 220.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaSize.height * 0.3,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: CupertinoActivityIndicator(
                      radius: 10,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: mediaPadding.bottom + 6),
                    child: copyright == ""
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[700]!,
                            highlightColor: Colors.grey[900]!,
                            child: Container(
                              width: 160,
                              height: 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Colors.grey[700],
                              ),
                            ),
                          )
                        : Text(
                            copyright,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFcccccc),
                              fontFamily: "Google-Sans",
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
