import 'package:flutter/material.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

import 'widgets/explore_appbar_widget.dart';
import 'widgets/explore_banner_widget.dart';
import 'widgets/explore_news_widget.dart';
import 'widgets/explore_service_menu_widget.dart';
import 'widgets/explore_event_widget.dart';

class ExploreView extends StatefulWidget {
  final Function moveToTab;
  const ExploreView({Key? key, required this.moveToTab}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onTapped(int index) {
    widget.moveToTab(index);
  }

  @override
  Widget build(BuildContext context) {
    // /var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      body: Stack(
        children: [
          ConstantConfig().background,
          NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [const ExploreAppBarWidget()];
            },
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: ExploreServiceMenuWidget(),
                ),
                const SliverToBoxAdapter(
                  child: ExploreEventWidget(),
                ),
                const SliverToBoxAdapter(
                  child: ExploreBannerWidget(),
                ),
                SliverToBoxAdapter(
                  child: ExploreNewsWidget(
                    moveToTab: onTapped,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: mediaPadding.bottom + 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
