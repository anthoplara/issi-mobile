import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/upcoming_list_model.dart';
import '../event_detail_view.dart';

class UpcomingItemWidget extends StatelessWidget {
  final UpcomingListData data;
  final String source;
  const UpcomingItemWidget({Key? key, required this.data, required this.source}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    String showDate = data.tglEvent ?? "-";
    if (showDate != "-") {
      DateTime date = DateTime.parse("$showDate 00:00:00");
      final DateFormat formatter = DateFormat('d MMMM yyyy');
      showDate = formatter.format(date);
    }
    String image = data.images ?? "";

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: BouncingButtonHelper(
        color: Colors.transparent,
        width: mediaSize.width - 44,
        autoHeight: true,
        onTap: () {
          Get.to(
            EventDetailView(
              dataId: data.idEvent.toString(),
              dataImage: image,
              source: source,
            ),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 400),
          );
        },
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
                image != ""
                    ? Hero(
                        tag: 'event_${source}_${data.idEvent}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 90,
                            width: 80,
                            child: CachedNetworkImage(
                              imageUrl: image,
                              placeholder: (context, url) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    height: 90,
                                    width: 80,
                                    color: Colors.grey[200],
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Container(
                                  height: 90,
                                  width: 80,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Image(
                                      image: AssetImage(
                                        'assets/images/handler/broken_image_64.png',
                                      ),
                                      width: 64.0,
                                    ),
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 120,
                        child: Center(
                          child: Image(
                            image: AssetImage(
                              'assets/images/handler/no_image_64.png',
                            ),
                            width: 64.0,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        showDate,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.orange[900],
                          fontSize: 12,
                          fontFamily: "Google-Sans",
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        data.namaEvent ?? "-",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: "Google-Sans",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          const Image(
                            image: AssetImage(
                              'assets/images/icons/pin_idle.png',
                            ),
                            width: 14.0,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            child: Text(
                              data.lokasi ?? "-",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[400]!,
                                fontSize: 12,
                                fontFamily: "Google-Sans",
                              ),
                            ),
                          ),
                        ],
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
