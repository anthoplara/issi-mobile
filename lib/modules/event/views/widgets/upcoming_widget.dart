import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/utils/networks/api_response.dart';

import '../../blocs/upcoming_bloc.dart';
import '../../models/upcoming_list_model.dart';
import 'upcoming_handler_widget.dart';
import 'upcoming_item_widget.dart';

class UpcomingWidget extends StatefulWidget {
  const UpcomingWidget({Key? key}) : super(key: key);

  @override
  State<UpcomingWidget> createState() => _UpcomingWidgetState();
}

class _UpcomingWidgetState extends State<UpcomingWidget> {
  final UpcomingBloc upcomingBloc = UpcomingBloc();

  List<Widget> _eventRows = [];
  ScrollController scrollController = ScrollController();
  int _currentPage = 1;
  bool _loadMore = true;
  bool _isLoading = false;
  int _shimmerLength = 6;
  String source = 'tab';

  @override
  void initState() {
    loadEvent(_currentPage);
    scrollController.addListener(_whenScroll);
    super.initState();
  }

  void _whenScroll() {
    double position = scrollController.position.pixels;
    double maxPosition = scrollController.position.maxScrollExtent;
    if (position >= maxPosition - 20 && !_isLoading && _loadMore) {
      _isLoading = true;
      loadEvent(_currentPage);
    }
  }

  void loadEvent(int page) {
    upcomingBloc.fetchResponse(page, 10);
  }

  @override
  void dispose() {
    upcomingBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;

    return Scaffold(
      extendBody: true,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 12,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    child: Column(
                      children: List.generate(_eventRows.length, (index) {
                        return _eventRows[index];
                      }),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: mediaSize.width,
                    child: StreamBuilder<dynamic>(
                      stream: upcomingBloc.antDataStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data!.status!) {
                            case Status.initial:
                              return const SizedBox.shrink();
                            case Status.loading:
                              List<Widget> shimmer = [];
                              for (var i = 0; i < (_currentPage == 1 ? _shimmerLength : 1); ++i) {
                                shimmer.add(const UpcomingItemShimmerWidget());
                              }
                              return Column(
                                children: shimmer,
                              );
                            case Status.completed:
                              UpcomingListModel responses = snapshot.data!.data as UpcomingListModel;
                              List<Widget> eventRows = [];
                              if (responses.data!.isNotEmpty) {
                                for (var item in responses.data!) {
                                  eventRows.add(
                                    UpcomingItemWidget(
                                      data: item,
                                      source: 'tab',
                                    ),
                                  );
                                }
                              } else {
                                Timer(
                                  const Duration(milliseconds: 1),
                                  () => {
                                    setState(() {
                                      _loadMore = false;
                                    })
                                  },
                                );
                                if (_eventRows.isEmpty) {
                                  eventRows.add(const UpcomingItemEmptyWidget());
                                }
                              }

                              upcomingBloc.setInitial();
                              Timer(
                                const Duration(milliseconds: 1),
                                () => {
                                  setState(() {
                                    _currentPage += 1;
                                    _isLoading = false;
                                    _eventRows.addAll(eventRows);
                                  })
                                },
                              );
                              return Container();
                            case Status.errror:
                              if (_eventRows.isEmpty) {
                                return const UpcomingItemErrorWidget();
                              } else {
                                return const SizedBox.shrink();
                              }
                          }
                        }
                        return Container();
                      },
                    ),
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
        ],
      ),
    );
  }
}
