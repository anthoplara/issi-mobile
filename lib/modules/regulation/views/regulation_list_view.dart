/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

import '../blocs/regulation_list_bloc.dart';
import '../models/regulation_list_model.dart';

class RegulationView extends StatefulWidget {
  const RegulationView({Key? key}) : super(key: key);

  @override
  State<RegulationView> createState() => _RegulationViewState();
}

class _RegulationViewState extends State<RegulationView> {
  final RegulationListBloc raceListBloc = RegulationListBloc();

  List<Widget> _raceRows = [];
  ScrollController scrollController = ScrollController();
  int _currentPage = 1;
  bool _loadMore = true;
  bool _isLoading = false;
  int _shimmerLength = 3;
  String source = 'tab';

  @override
  void initState() {
    loadRegulation(_currentPage);
    scrollController.addListener(_whenScroll);
    super.initState();
  }

  void _whenScroll() {
    double position = scrollController.position.pixels;
    double maxPosition = scrollController.position.maxScrollExtent;
    if (position >= maxPosition - 20 && !_isLoading && _loadMore) {
      _isLoading = true;
      loadRegulation(_currentPage);
    }
  }

  void loadRegulation(int page) {
    raceListBloc.fetchResponse(page, 10);
  }

  Future<void> _refreshListData() {
    setState(() {
      _currentPage = 1;
      _loadMore = true;
      _isLoading = false;
      _raceRows = [];
    });
    loadRegulation(_currentPage);
    return Future.delayed(const Duration(milliseconds: 500), () {});
  }

  @override
  void dispose() {
    raceListBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      extendBody: true,
      //appBar:
      body: Stack(
        children: [
          ConstantConfig().background,
          Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  color: Colors.orange[900],
                  strokeWidth: 1,
                  onRefresh: _refreshListData,
                  displacement: 100,
                  child: CustomScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        automaticallyImplyLeading: false,
                        centerTitle: false,
                        titleSpacing: 0.0,
                        elevation: 0,
                        title: Container(
                          color: Colors.transparent,
                          width: mediaSize.width,
                          height: 54,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
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
                                    color: Colors.black,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 6.0,
                                  ),
                                  child: Text(
                                    'Regulations',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontFamily: "Google-Sans",
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
                      SliverToBoxAdapter(
                        child: SizedBox(
                          child: Column(
                            children: List.generate(_raceRows.length, (index) {
                              return _raceRows[index];
                            }),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          width: mediaSize.width,
                          child: StreamBuilder<dynamic>(
                            stream: raceListBloc.antDataStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                switch (snapshot.data!.status!) {
                                  case Status.initial:
                                    return const SizedBox.shrink();
                                  case Status.loading:
                                    List<Widget> shimmer = [];
                                    for (var i = 0; i < (_currentPage == 1 ? _shimmerLength : 1); ++i) {
                                      shimmer.add(const RegulationItemShimmerWidget());
                                    }
                                    return Column(
                                      children: shimmer,
                                    );
                                  case Status.completed:
                                    RegulationListModel responses = snapshot.data!.data as RegulationListModel;
                                    List<Widget> raceRows = [];
                                    if (responses.data!.isNotEmpty) {
                                      for (var item in responses.data!) {
                                        raceRows.add(
                                          RegulationItemWidget(
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
                                      if (_raceRows.isEmpty) {
                                        raceRows.add(const RegulationItemEmptyWidget());
                                      }
                                    }
                                    raceListBloc.setInitial();
                                    Timer(
                                      const Duration(milliseconds: 1),
                                      () => {
                                        setState(() {
                                          _currentPage += 1;
                                          _isLoading = false;
                                          _raceRows.addAll(raceRows);
                                        })
                                      },
                                    );
                                    return Container();
                                  case Status.errror:
                                    if (_raceRows.isEmpty) {
                                      return const RegulationItemErrorWidget();
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
 */