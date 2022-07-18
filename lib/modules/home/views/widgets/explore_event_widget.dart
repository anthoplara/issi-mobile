import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/event/blocs/event_list_bloc.dart';
import 'package:mobile/modules/event/models/event_list_model.dart';
import 'package:mobile/modules/event/views/event_view.dart';
import 'package:mobile/modules/event/views/widgets/event_item_large_handler_widget.dart';
import 'package:mobile/modules/event/views/widgets/event_item_large_widget.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';

class ExploreEventWidget extends StatefulWidget {
  const ExploreEventWidget({Key? key}) : super(key: key);

  @override
  State<ExploreEventWidget> createState() => _ExploreEventWidgetState();
}

class _ExploreEventWidgetState extends State<ExploreEventWidget> {
  final EventListBloc eventListBloc = EventListBloc();

  @override
  void initState() {
    eventListBloc.fetchResponse(1, 5);
    super.initState();
  }

  @override
  void dispose() {
    eventListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    double h = MediaQuery.of(context).textScaleFactor;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 14,
            right: 16,
            bottom: 14,
            left: 22,
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Events',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: "Google-Sans",
                  ),
                ),
              ),
              BouncingButtonHelper(
                autoWidth: true,
                autoHeight: true,
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(30.0),
                bouncDeep: 0.2,
                onTap: () {
                  Get.to(
                    const EventView(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 400),
                  );
                },
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontFamily: "Google-Sans",
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_right,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
        SizedBox(
          width: mediaSize.width,
          height: 250,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  width: 22,
                ),
              ),
              SliverToBoxAdapter(
                child: StreamBuilder<dynamic>(
                  stream: eventListBloc.antDataStream,
                  builder: (context, snapshot) {
                    List<Widget> defaultWidget = [
                      const EventItemLargeShimmerWidget(),
                      const EventItemLargeShimmerWidget(),
                      const EventItemLargeShimmerWidget(),
                      const EventItemLargeShimmerWidget(),
                      const EventItemLargeShimmerWidget(),
                    ];
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status!) {
                        case Status.initial:
                          return Row(
                            children: defaultWidget,
                          );
                        case Status.loading:
                          return Row(
                            children: defaultWidget,
                          );
                        case Status.completed:
                          EventListModel responses = snapshot.data!.data as EventListModel;
                          List<Widget> eventRows = [];
                          if (responses.data!.isNotEmpty) {
                            for (var item in responses.data!) {
                              eventRows.add(EventItemLargeWidget(
                                data: item,
                              ));
                            }
                          } else {
                            eventRows.add(const EventItemLargeEmptyWidget());
                          }
                          return Row(
                            children: eventRows,
                          );
                        case Status.errror:
                          return const EventItemLargeErrorWidget();
                      }
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
