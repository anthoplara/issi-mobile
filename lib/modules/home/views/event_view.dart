import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/modules/event/views/widgets/past_widget.dart';
import 'package:mobile/modules/event/views/widgets/upcoming_widget.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

class MyEventView extends StatefulWidget {
  const MyEventView({Key? key}) : super(key: key);

  @override
  State<MyEventView> createState() => _MyEventViewState();
}

class _MyEventViewState extends State<MyEventView> {
  List<Widget> _list = [];
  int tabPosition = 0;

  @override
  void initState() {
    _list = [
      const UpcomingWidget(),
      const PastWidget(),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeTabPosition(int index) {
    setState(() {
      tabPosition = 0;
    });
    Timer(
      const Duration(milliseconds: 100),
      () {
        setState(() {
          tabPosition = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    double maxTabWidth = (mediaSize.width - 44) > 250 ? 250 : (mediaSize.width - 44);
    double headerHeight = mediaPadding.top + 54 + 58;
    double contentHeight = mediaSize.height - headerHeight;

    return Scaffold(
      extendBody: true,
      //appBar:
      body: Stack(
        children: [
          ConstantConfig().background,
          Column(
            children: [
              SizedBox(
                height: headerHeight,
              ),
              SizedBox(
                width: mediaSize.width,
                height: contentHeight,
                child: IndexedStack(
                  index: tabPosition,
                  children: _list,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.only(top: mediaPadding.top, left: 22, right: 22),
                  height: mediaPadding.top + 54,
                  width: mediaSize.width,
                  color: Colors.transparent,
                  child: Row(
                    children: const [
                      Text(
                        'My Events',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontFamily: "Google-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 58,
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 10.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: maxTabWidth,
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: const Color(0xFFdce9ed),
                        ),
                        child: Center(
                          child: SizedBox(
                            height: 34,
                            width: maxTabWidth - 10,
                            child: Stack(
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 200),
                                  left: tabPosition == 0 ? 0 : (maxTabWidth - 10) / 2,
                                  right: tabPosition == 0 ? (maxTabWidth - 10) / 2 : 0,
                                  child: Container(
                                    width: (maxTabWidth - 10) / 2,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFf7fafb),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 34,
                                  width: maxTabWidth - 10,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      BouncingButtonHelper(
                                        width: (maxTabWidth - 10) / 2,
                                        height: 34,
                                        color: Colors.transparent,
                                        bouncDeep: 0.2,
                                        onTap: () {
                                          changeTabPosition(0);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            'UPCOMING',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: tabPosition == 0 ? Colors.orange[900] : Colors.grey,
                                              fontSize: 16.0,
                                              fontFamily: "Google-Sans",
                                            ),
                                          ),
                                        ),
                                      ),
                                      BouncingButtonHelper(
                                        width: (maxTabWidth - 10) / 2,
                                        height: 34,
                                        color: Colors.transparent,
                                        bouncDeep: 0.2,
                                        onTap: () {
                                          changeTabPosition(1);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            'PAST EVENTS',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: tabPosition == 1 ? Colors.orange[900] : Colors.grey,
                                              fontSize: 16.0,
                                              fontFamily: "Google-Sans",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
