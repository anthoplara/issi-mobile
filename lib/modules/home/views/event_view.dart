import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';

import 'widgets/event_past_widget.dart';
import 'widgets/event_upcoming_widget.dart';

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
      const EventUpcomingWidget(),
      const EventPastWidget(),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      extendBody: true,
      //appBar:
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFF3F6FB),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
                      expandedHeight: 120,
                      titleSpacing: 0.0,
                      elevation: 0,
                      title: SizedBox(
                        width: mediaSize.width,
                        height: 54,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                          ),
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
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
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
                                              BouncingButtonHelper(
                                                width: (maxTabWidth - 10) / 2,
                                                height: 34,
                                                color: Colors.transparent,
                                                bouncDeep: 0.2,
                                                onTap: () {
                                                  changeTabPosition(1);
                                                },
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
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 12,
                      ),
                    ),
                    /* SliverToBoxAdapter(
                      child: Container(
                        width: mediaSize.width,
                        child: IndexedStack(
                          index: tabPosition,
                          children: _list,
                        ),
                      ),
                    ), */
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: mediaPadding.bottom + 22,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
