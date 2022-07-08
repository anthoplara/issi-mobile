import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/modules/event/views/event_view.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';

import 'event_view.dart';
import 'profile_view.dart';
import 'widgets/navbar_custom_circular_widget.dart';
import 'widgets/navbar_fab_widget.dart';

import 'explore_view.dart';
import 'news_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<NavBarFloatingActionButtonWidgetState> dashboardGlobalKey = GlobalKey<NavBarFloatingActionButtonWidgetState>();
  GetStorage localData = GetStorage();

  bool showAnnouncement = false;
  int _currentIndex = 0;
  List<Widget> _list = [];

  List<String> images = [];

  @override
  void initState() {
    _list = [
      ExploreView(
        moveToTab: _onCallbackTap,
      ),
      const MyEventView(),
      const NewsView(),
      const ProfileView(),
    ];
    super.initState();
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
      child: Stack(
        children: [
          Scaffold(
            extendBody: true,
            bottomNavigationBar: NavBarFloatingActionButtonWidget(
              key: dashboardGlobalKey,
              height: 72,
              defaultSelected: _currentIndex,
              centerItemText: '',
              color: Colors.grey,
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFFf37501),
              notchedShape: NavBarCustomCircularShape(),
              onTabSelected: _onTapped,
              items: [
                NavBarFloatingActionButtonItemWidget(
                  //iconData: Icons.dashboard,
                  icon: 'compas',
                  text: 'Explore',
                ),
                NavBarFloatingActionButtonItemWidget(
                  //iconData: FontAwesomeIcons.calendarDays,
                  icon: 'calendar',
                  text: 'My Event',
                ),
                NavBarFloatingActionButtonItemWidget(
                  //iconData: FontAwesomeIcons.mapPin,
                  icon: 'pin',
                  text: 'News',
                ),
                NavBarFloatingActionButtonItemWidget(
                  //iconData: FontAwesomeIcons.userDoctor,
                  icon: 'user',
                  text: 'Profile',
                ),
              ],
            ),
            body: IndexedStack(
              index: _currentIndex,
              children: _list,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: 60.0,
                    width: 60.0,
                    child: BouncingButtonHelper(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.0),
                      bouncDeep: 0.2,
                      onTap: () {},
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xFFf37501),
                        elevation: 10,
                        onPressed: () {
                          Get.to(
                            const EventView(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 400),
                          );
                        },
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: const BoxDecoration(
                            color: Color(0xFFf37501),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Image(
                              image: AssetImage(
                                'assets/images/icons/plus.png',
                              ),
                              width: 20.0,
                            ),
                          ),
                        ),
                        //elevation: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onCallbackTap(int index) {
    //_onTapped(index);
    dashboardGlobalKey.currentState?.updateIndex(index);
  }
}
