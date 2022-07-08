import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/helpers/fade_slide_delay.dart';
import 'package:mobile/utils/networks/key_storage.dart';

import '../../home/views/dashboard_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  GetStorage localData = GetStorage();
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: topSliderLayout(),
    );
  }
  //Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: Stack(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: sliderArrayList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Image(
                      image: AssetImage(
                        'assets/images/logo_full.png',
                      ),
                      width: 100.0,
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  _currentPage == 4
                      ? FadeSlideDelayHelper(
                          length: 0.04,
                          delay: 1000,
                          direction: 'bottom',
                          child: Container(
                            alignment: AlignmentDirectional.bottomCenter,
                            margin: const EdgeInsets.only(bottom: 48.0),
                            child: BouncingButtonHelper(
                              width: 220,
                              height: 42,
                              color: Colors.blue[800]!,
                              onTap: () {
                                localData.write(KeyStorage.isOnboarded, "seen");
                                Get.offAll(
                                  const DashboardView(),
                                  transition: Transition.fadeIn,
                                  duration: const Duration(milliseconds: 1000),
                                );
                              },
                              child: const Text(
                                "Masuk",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Google-Sans",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < sliderArrayList.length; i++)
                          if (i == _currentPage) SlideDots(true) else SlideDots(false)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Slider {
  final String? sliderImage;
  final String? sliderHeading;
  final String? sliderSubHeading;

  Slider({
    @required this.sliderImage,
    @required this.sliderHeading,
    @required this.sliderSubHeading,
  });
}

final sliderArrayList = [
  Slider(sliderImage: 'assets/images/logo_icon.png', sliderHeading: Constants.sliderHeading_1, sliderSubHeading: Constants.sliderDescription_1),
  Slider(sliderImage: 'assets/images/logo_icon.png', sliderHeading: Constants.sliderHeading_2, sliderSubHeading: Constants.sliderDescription_2),
  Slider(sliderImage: 'assets/images/logo_icon.png', sliderHeading: Constants.sliderHeading_3, sliderSubHeading: Constants.sliderDescription_3),
  Slider(sliderImage: 'assets/images/logo_icon.png', sliderHeading: Constants.sliderHeading_4, sliderSubHeading: Constants.sliderDescription_4),
  Slider(sliderImage: 'assets/images/logo_icon.png', sliderHeading: Constants.sliderHeading_5, sliderSubHeading: Constants.sliderDescription_5),
];

class Constants {
  static const String login = "Login";
  static const String home = "Beranda";

  static const String sliderHeading_1 = "ISSI Mobile";
  static const String sliderHeading_2 = "Explore";
  static const String sliderHeading_3 = "Event";
  static const String sliderHeading_4 = "News";
  static const String sliderHeading_5 = "Regulation";

  static const String sliderDescription_1 =
      "Keterangan 1: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  static const String sliderDescription_2 =
      "Keterangan 2: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  static const String sliderDescription_3 =
      "Keterangan 3: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  static const String sliderDescription_4 =
      "Keterangan 4: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
  static const String sliderDescription_5 =
      "Keterangan 5: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
}

class SlideItem extends StatelessWidget {
  final int index;
  const SlideItem(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.6,
          width: MediaQuery.of(context).size.height * 0.4,
          child: Center(
            child: Image(
              image: AssetImage(
                sliderArrayList[index].sliderImage!,
              ),
              width: 220.0,
            ),
          ),
        ),
        const SizedBox(
          height: 60.0,
        ),
        FadeSlideDelayHelper(
          delay: 0,
          child: Text(
            sliderArrayList[index].sliderHeading!,
            style: const TextStyle(
              fontFamily: 'Google-Sans',
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        FadeSlideDelayHelper(
          delay: 500,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                sliderArrayList[index].sliderSubHeading!,
                style: const TextStyle(
                  fontFamily: 'Google-Sans',
                  fontSize: 15.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive ? 10 : 6,
      width: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        border: isActive
            ? Border.all(
                color: Colors.blue,
                width: 2.0,
              )
            : Border.all(
                color: Colors.transparent,
                width: 1,
              ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
