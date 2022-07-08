import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/modules/news/blocs/news_list_bloc.dart';
import 'package:mobile/modules/news/models/news_list_model.dart';
import 'package:mobile/modules/news/views/widgets/news_item_handler_widget.dart';
import 'package:mobile/modules/news/views/widgets/news_item_widget.dart';
import 'package:mobile/utils/networks/api_response.dart';

class NewsView extends StatefulWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final NewsListBloc newsListBloc = NewsListBloc();

  List<Widget> _newsRows = [];
  ScrollController scrollController = ScrollController();
  int _currentPage = 1;
  bool _loadMore = true;
  bool _isLoading = false;
  int _shimmerLength = 6;
  String source = 'tab';

  @override
  void initState() {
    loadNews(_currentPage);
    scrollController.addListener(_whenScroll);
    super.initState();
  }

  void _whenScroll() {
    double position = scrollController.position.pixels;
    double maxPosition = scrollController.position.maxScrollExtent;
    if (position >= maxPosition - 20 && !_isLoading && _loadMore) {
      _isLoading = true;
      loadNews(_currentPage);
    }
  }

  void loadNews(int page) {
    newsListBloc.fetchResponse(1, page, 10);
  }

  @override
  void dispose() {
    newsListBloc.dispose();
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
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      centerTitle: false,
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
                                'News',
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
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 12,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        child: Column(
                          children: List.generate(_newsRows.length, (index) {
                            return _newsRows[index];
                          }),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: mediaSize.width,
                        child: StreamBuilder<dynamic>(
                          stream: newsListBloc.antDataStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data!.status!) {
                                case Status.initial:
                                  return const SizedBox.shrink();
                                case Status.loading:
                                  List<Widget> shimmer = [];
                                  for (var i = 0; i < (_currentPage == 1 ? _shimmerLength : 1); ++i) {
                                    shimmer.add(const NewsItemShimmerWidget());
                                  }
                                  return Column(
                                    children: shimmer,
                                  );
                                case Status.completed:
                                  NewsListModel responses = snapshot.data!.data as NewsListModel;
                                  List<Widget> newsRows = [];
                                  if (responses.data!.isNotEmpty) {
                                    for (var item in responses.data!) {
                                      newsRows.add(
                                        NewsItemWidget(
                                          data: item,
                                          source: source,
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
                                    if (_newsRows.isEmpty) {
                                      newsRows.add(const NewsItemEmptyWidget());
                                    }
                                  }
                                  /* return Column(
                                    children: newsRows,
                                  ); */
                                  newsListBloc.setInitial();
                                  Timer(
                                    const Duration(milliseconds: 1),
                                    () => {
                                      setState(() {
                                        _currentPage += 1;
                                        _isLoading = false;
                                        _newsRows.addAll(newsRows);
                                      })
                                    },
                                  );
                                  return Container();
                                case Status.errror:
                                  return const SizedBox.shrink();
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
        ],
      ),
    );
  }
}
