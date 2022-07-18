import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/news/blocs/news_list_bloc.dart';
import 'package:mobile/modules/news/models/news_list_model.dart';
import 'package:mobile/modules/news/views/news_detail_view.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class ExploreBannerWidget extends StatefulWidget {
  const ExploreBannerWidget({Key? key}) : super(key: key);

  @override
  State<ExploreBannerWidget> createState() => _ExploreBannerWidgetState();
}

class _ExploreBannerWidgetState extends State<ExploreBannerWidget> {
  final NewsListBloc newsListBloc = NewsListBloc();
  bool loadData = true;
  List<Widget> data = [];

  @override
  void initState() {
    newsListBloc.fetchResponse(2, 1, 3);
    super.initState();
  }

  @override
  void dispose() {
    newsListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Column(
      children: [
        !loadData
            ? data.isNotEmpty
                ? data.length == 1
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: data[0],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: CarouselSlider(
                          items: data,
                          options: CarouselOptions(
                            height: 125,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            autoPlayInterval: const Duration(seconds: 6),
                            autoPlayAnimationDuration: const Duration(milliseconds: 600),
                            disableCenter: true,
                            viewportFraction: ((mediaSize.width > 420 ? 420 : mediaSize.width) - 44) / (mediaSize.width - 44),
                            initialPage: 0,
                          ),
                        ),
                      )
                : const SizedBox.shrink()
            : SizedBox(
                width: mediaSize.width,
                child: StreamBuilder<dynamic>(
                  stream: newsListBloc.antDataStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status!) {
                        case Status.initial:
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical: 8,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[200]!,
                              child: Container(
                                width: mediaSize.width * 0.8,
                                height: 125,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]!),
                              ),
                            ),
                          );
                        case Status.loading:
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical: 8,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[200]!,
                              child: Container(
                                width: mediaSize.width * 0.8,
                                height: 125,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]!),
                              ),
                            ),
                          );
                        case Status.completed:
                          NewsListModel responses = snapshot.data!.data as NewsListModel;
                          List<Widget> bannerRows = [];
                          if (responses.data!.isNotEmpty) {
                            for (var item in responses.data!) {
                              String image = item.images ?? "";
                              if (image != "") {
                                bannerRows.add(sliderItem(
                                  item,
                                  mediaSize,
                                ));
                              }
                            }
                          } else {}
                          Timer(
                            const Duration(milliseconds: 1),
                            () {
                              setState(() {
                                loadData = false;
                                data = bannerRows;
                              });
                            },
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22.0,
                              vertical: 8,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[200]!,
                              child: Container(
                                width: mediaSize.width * 0.8,
                                height: 125,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.grey[200]!),
                              ),
                            ),
                          );
                        case Status.errror:
                          return Container();
                      }
                    }
                    return Container();
                  },
                ),
              ),
      ],
    );
  }

  Widget sliderItem(NewsListData data, Size mediaSize) {
    String heroTag = const Uuid().v4();
    return BouncingButtonHelper(
      color: Colors.transparent,
      width: mediaSize.width - 44,
      autoHeight: true,
      onTap: () {
        Get.to(
          NewsDetailView(
            data: data,
            heroTag: heroTag,
          ),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 400),
        );
      },
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: mediaSize.width - 44,
            height: 125,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: data.images,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 125,
                    width: mediaSize.width - 44,
                    color: Colors.grey[200],
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  height: 125,
                  width: mediaSize.width - 44,
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
    );
  }
}
