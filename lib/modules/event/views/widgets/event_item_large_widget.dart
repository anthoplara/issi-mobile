import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/event/models/event_list_model.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/helpers/date_helper.dart';
import 'package:shimmer/shimmer.dart';

import '../event_detail_view.dart';

class EventItemLargeWidget extends StatelessWidget {
  final EventListData data;

  const EventItemLargeWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String source = 'exp';
    var datePart = data.tglEvent!.split('-');
    int people = int.parse(data.totalOrangMendaftar ?? "0");
    String image = data.images ?? "";
    String going = (people == 0 ? "No one" : (people > 20 ? "+20" : people.toString()));
    List<String> photoData = (data.userFoto ?? "").split(",");
    List<Widget> photoCircle = [];
    int index = photoData.length;
    if (people != 0) {
      for (var item in photoData.reversed) {
        --index;
        photoCircle.add(
          Padding(
            padding: EdgeInsets.only(
              left: (14 * index).toDouble(),
            ),
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 11,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: CachedNetworkImage(
                      imageUrl: item,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 22,
                            width: 22,
                            color: Colors.grey[200],
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          height: 22,
                          width: 22,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.error),
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(right: 22.0, bottom: 22),
      child: BouncingButtonHelper(
        color: Colors.transparent,
        width: 240,
        autoHeight: true,
        onTap: () {
          Get.to(
            EventDetailView(
              dataId: data.id.toString(),
              dataImage: image,
              source: source,
            ),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 400),
          );
        },
        child: Container(
          width: 240,
          //height: 230,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    image != ""
                        ? Hero(
                            tag: 'event_${source}_${data.id}',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                height: 120,
                                width: 240,
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  placeholder: (context, url) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: 100,
                                        width: 240,
                                        color: Colors.grey[200],
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      height: 100,
                                      width: 240,
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
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Text(
                                datePart[2],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 16,
                                  fontFamily: "Google-Sans",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                monthShort[int.parse(datePart[1]) - 1],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.orange[900],
                                  fontSize: 12,
                                  fontFamily: "Google-Sans",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  data.namaEvent ?? '-',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: "Google-Sans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    photoCircle.isNotEmpty
                        ? Stack(
                            children: photoCircle,
                          )
                        : const SizedBox.shrink(),
                    photoCircle.isEmpty
                        ? const SizedBox.shrink()
                        : const SizedBox(
                            width: 8,
                          ),
                    /* const SizedBox(
                        width: 0,
                      ), */
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        child: Text(
                          '$going going',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.orange[900],
                            fontSize: 12,
                            fontFamily: "Google-Sans",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 6,
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
                        (data.lokasi ?? '-') == "" ? "Unknown" : (data.lokasi ?? '-'),
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
          ),
        ),
      ),
    );
  }
}
