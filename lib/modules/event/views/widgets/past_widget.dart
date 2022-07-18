import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

import '../../blocs/past_bloc.dart';
import '../../models/past_list_model.dart';
import 'past_handler_widget.dart';
import 'past_item_widget.dart';

class PastWidget extends StatefulWidget {
  const PastWidget({Key? key}) : super(key: key);

  @override
  State<PastWidget> createState() => _PastWidgetState();
}

class _PastWidgetState extends State<PastWidget> {
  final PastBloc pastBloc = PastBloc();

  List<Widget> _eventRows = [];
  ScrollController scrollController = ScrollController();
  int _currentPage = 1;
  bool _loadMore = true;
  bool _isLoading = false;
  int _shimmerLength = 3;
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
    pastBloc.fetchResponse(page, 10);
  }

  Future<void> _refreshListData() {
    setState(() {
      _currentPage = 1;
      _loadMore = true;
      _isLoading = false;
      _eventRows = [];
    });
    loadEvent(_currentPage);
    return Future.delayed(const Duration(milliseconds: 500), () {});
  }

  @override
  void dispose() {
    pastBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          ConstantConfig().background,
          RefreshIndicator(
            color: Colors.orange[900],
            strokeWidth: 1,
            onRefresh: _refreshListData,
            displacement: 100,
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    child: Column(
                      children: List.generate(_eventRows.length, (index) {
                        return _eventRows[index];
                      }),
                    ),
                  ),
                  SizedBox(
                    width: mediaSize.width,
                    child: StreamBuilder<dynamic>(
                      stream: pastBloc.antDataStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch (snapshot.data!.status!) {
                            case Status.initial:
                              return const SizedBox.shrink();
                            case Status.loading:
                              List<Widget> shimmer = [];
                              for (var i = 0; i < (_currentPage == 1 ? _shimmerLength : 1); ++i) {
                                shimmer.add(const PastItemShimmerWidget());
                              }
                              return Column(
                                children: shimmer,
                              );
                            case Status.completed:
                              PastListModel responses = snapshot.data!.data as PastListModel;
                              List<Widget> eventRows = [];
                              if (responses.data!.isNotEmpty) {
                                for (var item in responses.data!) {
                                  eventRows.add(
                                    PastItemWidget(
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
                                  eventRows.add(const PastItemEmptyWidget());
                                }
                              }

                              pastBloc.setInitial();
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
                                return const PastItemErrorWidget();
                              } else {
                                return const SizedBox.shrink();
                              }
                          }
                        }
                        return Container();
                      },
                    ),
                  ),
                  SizedBox(
                    height: mediaPadding.bottom + 22,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
