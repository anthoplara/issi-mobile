import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:shimmer/shimmer.dart';

import '../event_view.dart';

class UpcomingItemShimmerWidget extends StatelessWidget {
  const UpcomingItemShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BouncingButtonHelper(
        color: Colors.transparent,
        width: mediaSize.width - 44,
        autoHeight: true,
        onTap: () {},
        child: Container(
          //width: mediaSize.width - 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300]!.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 90,
                    width: 80,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]!),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 12,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 14,
                            //width: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 14,
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 12,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
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
    );
  }
}

class UpcomingItemEmptyWidget extends StatelessWidget {
  const UpcomingItemEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SizedBox(
        height: mediaSize.height - mediaPadding.vertical - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(
                'assets/images/handler/no_data.png',
              ),
              width: 200.0,
            ),
            const SizedBox(
              height: 32,
            ),
            const Text(
              "No Upcoming Event",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: "Google-Sans",
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            const Center(
              child: Text(
                "Ayo bergabung dalam event ISSI dan membangun pertemanan antar anggota ISSI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff444444),
                  fontSize: 14,
                  fontFamily: "Google-Sans",
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            BouncingButtonHelper(
              width: 240,
              height: 54,
              color: const Color(0xff222222),
              onTap: () async {
                Get.to(
                  const EventView(),
                  transition: Transition.fadeIn,
                  duration: const Duration(milliseconds: 400),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: const [
                    Expanded(
                      child: Center(
                        child: Text(
                          "EXPLORE EVENTS",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Google-Sans",
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: Colors.white,
                      ),
                    )
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

class UpcomingItemErrorWidget extends StatelessWidget {
  const UpcomingItemErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: SizedBox(
        height: mediaSize.height - mediaPadding.vertical - 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage(
                'assets/images/handler/error.png',
              ),
              width: 200.0,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Something when Wrong",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontFamily: "Google-Sans",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
