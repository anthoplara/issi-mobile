import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/modules/event/views/widgets/fab_join_event_widget.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/event_detail_bloc.dart';
import '../models/event_detail_model.dart';

class EventDetailView extends StatefulWidget {
  final String dataId;
  final String dataImage;
  final String heroTag;
  const EventDetailView({Key? key, required this.dataId, required this.dataImage, required this.heroTag}) : super(key: key);

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView> {
  EventDetailBloc eventDetailBloc = EventDetailBloc();

  StreamController joinEventStream = StreamController();

  bool isLoading = true;
  bool allowRegister = false;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    setState(() {
      isLoading = true;
      allowRegister = false;
    });
    eventDetailBloc.fetchResponse(widget.dataId);
  }

  @override
  void dispose() {
    eventDetailBloc.dispose();
    super.dispose();
  }

  void callbackJoin(String status) {
    if (status == "1") {
      Timer(const Duration(milliseconds: 10), () {
        loadData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[200]!,
              child: Container(
                width: 220,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          : allowRegister
              ? FabJoinEventWidget(dataId: widget.dataId, callback: callbackJoin)
              : const SizedBox.shrink(),
      extendBody: true,
      body: Stack(
        children: [
          ConstantConfig().background,
          SizedBox(
            child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: const Color(0xFF222222),
                    pinned: false,
                    expandedHeight: mediaSize.shortestSide * 0.4,
                    automaticallyImplyLeading: false,
                    centerTitle: false,
                    title: Container(
                      color: Colors.transparent,
                      width: mediaSize.width,
                      height: 54,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 0,
                          right: 22,
                        ),
                        child: Row(
                          children: [
                            BouncingButtonHelper(
                              width: 54,
                              height: 54,
                              color: Colors.transparent,
                              bouncDeep: 0.9,
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 6.0,
                              ),
                              child: Text(
                                'Event Detail',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontFamily: "Google-Sans",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: widget.heroTag,
                        child: CachedNetworkImage(
                          imageUrl: widget.dataImage,
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
                  ),
                ];
              },
              body: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 16,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: StreamBuilder<dynamic>(
                      stream: eventDetailBloc.antDataStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data!.status!) {
                            case Status.initial:
                              return shimmerEvent();
                            case Status.loading:
                              return shimmerEvent();
                            case Status.completed:
                              EventDetailModel responses = snapshot.data!.data as EventDetailModel;
                              Widget eventPage = const SizedBox.shrink();
                              if (responses.data!.isNotEmpty) {
                                for (var item in responses.data!) {
                                  eventPage = pageEvent(item);
                                }
                              }
                              return eventPage;
                            case Status.errror:
                              return const SizedBox.shrink();
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: mediaPadding.bottom + 22,
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

  Widget pageEvent(EventDetailData data) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    bool _allowRegister = allowRegister;
    String dateTop = "-";
    String dateFromServer = data.tglEvent ?? "-";

    if (dateFromServer != "") {
      DateTime dt = DateTime.parse(dateFromServer);
      _allowRegister = dt.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch;
      dateTop = DateFormat('d MMMM yyyy').format(dt);
    }

    if (data.sudahTerdaftar == "1") {
      _allowRegister = false;
    }

    String dateBottom = "-";
    String startTimeFromServer = data.jamAwal ?? "-";
    String endTimeFromServer = data.jamAkhir ?? "-";
    if (startTimeFromServer != "-" && endTimeFromServer != "-") {
      DateTime dtStart = DateTime.parse(startTimeFromServer);
      DateTime dtEnd = DateTime.parse(endTimeFromServer);

      String dayName = DateFormat('EEEE').format(dtStart);
      String timeStart = DateFormat('hh:mma').format(dtStart);
      String timeEnd = DateFormat('hh:mma').format(dtEnd);
      dateBottom = "$dayName, $timeStart - $timeEnd";
    }

    int people = int.parse(data.totalOrangMendaftar ?? "0");
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
              left: (25 * index).toDouble(),
            ),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 17,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11),
                  child: SizedBox(
                    height: 34,
                    width: 34,
                    child: CachedNetworkImage(
                      imageUrl: item,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 34,
                            width: 34,
                            color: Colors.grey[200],
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          height: 34,
                          width: 34,
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

    Timer(
      const Duration(milliseconds: 10),
      () => {
        setState(() {
          isLoading = false;
          allowRegister = _allowRegister;
        })
      },
    );

    return Column(
      children: [
        Center(
          child: Container(
            width: (mediaSize.width * 0.8) > 300 ? 300 : (mediaSize.width * 0.8),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Row(
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
                  Expanded(
                    child: Center(
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
                            fontSize: 15,
                            fontFamily: "Google-Sans",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.namaEvent ?? "-",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  fontFamily: "Google-Sans",
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              eventInfoList('timetable', dateTop, dateBottom),
              eventInfoList('location', data.lokasi ?? "-", "Lokasi"),
              eventInfoList('organization', data.organizer ?? "-", 'Organizer'),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'About Event',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "Google-Sans",
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              HtmlWidget(
                data.deskripsi ?? "-",
                textStyle: TextStyle(
                  fontSize: 14.0,
                  fontFamily: "Google-Sans",
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shimmerEvent() {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Column(
      children: [
        Center(
          child: Container(
            width: (mediaSize.width * 0.8) > 300 ? 300 : (mediaSize.width * 0.8),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 17,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 17,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 0,
                        ),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              radius: 17,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[200]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 15,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 22,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 22,
                    width: mediaSize.width / 2,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50,
                    width: mediaSize.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50,
                    width: mediaSize.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 50,
                    width: mediaSize.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 16,
                    width: mediaSize.width / 2,
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
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: (mediaSize.width - 44) / 2,
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
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: mediaSize.width - 44,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 14,
                    width: (mediaSize.width - 44) / 3,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget eventInfoList(String image, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xfffff2e9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Image(
                image: AssetImage(
                  'assets/images/icons/$image.png',
                ),
                width: 22.0,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "Google-Sans",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
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
    );
  }
}
