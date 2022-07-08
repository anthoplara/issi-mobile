import 'package:flutter/material.dart';
import 'package:mobile/modules/news/blocs/news_list_bloc.dart';
import 'package:mobile/modules/news/models/news_list_model.dart';
import 'package:mobile/modules/news/views/widgets/news_item_handler_widget.dart';
import 'package:mobile/modules/news/views/widgets/news_item_widget.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';

class ExploreNewsWidget extends StatefulWidget {
  final Function moveToTab;
  const ExploreNewsWidget({Key? key, required this.moveToTab}) : super(key: key);

  @override
  State<ExploreNewsWidget> createState() => _ExploreNewsWidgetState();
}

class _ExploreNewsWidgetState extends State<ExploreNewsWidget> {
  final NewsListBloc newsListBloc = NewsListBloc();

  String source = 'exp';

  @override
  void initState() {
    newsListBloc.fetchResponse(1, 1, 5);
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
    return Padding(
      padding: const EdgeInsets.only(
        top: 14,
        right: 16,
        bottom: 14,
        left: 22,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'News',
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
                    widget.moveToTab(2);
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
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: mediaSize.width,
              child: StreamBuilder<dynamic>(
                stream: newsListBloc.antDataStream,
                builder: (context, snapshot) {
                  List<Widget> defaultWidget = [
                    const NewsItemShimmerWidget(),
                    const NewsItemShimmerWidget(),
                    const NewsItemShimmerWidget(),
                    const NewsItemShimmerWidget(),
                    const NewsItemShimmerWidget(),
                  ];
                  if (snapshot.hasData) {
                    switch (snapshot.data!.status!) {
                      case Status.initial:
                        return Column(
                          children: defaultWidget,
                        );
                      case Status.loading:
                        return Column(
                          children: defaultWidget,
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
                          newsRows.add(const NewsItemEmptyWidget());
                        }
                        return Column(
                          children: newsRows,
                        );
                      case Status.errror:
                        return const NewsItemErrorWidget();
                    }
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
