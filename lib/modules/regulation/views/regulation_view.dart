import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

class RegulationView extends StatelessWidget {
  const RegulationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      extendBody: true,
      body: Stack(
        children: [
          ConstantConfig().background,
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
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
                                child: Hero(
                                  tag: "regulation_title",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      'Regulations',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: SizedBox(
                          height: mediaSize.height - mediaPadding.vertical - 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage(
                                  'assets/images/handler/no_data.png',
                                ),
                                width: 200.0,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                "Coming Soon",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

import '../blocs/regulation_bloc.dart';
import '../models/regulation_model.dart';
import 'regulation_list_view.dart';
import 'widgets/regulation_handler_widget.dart';
import 'widgets/regulation_widget.dart';

class RegulationView extends StatefulWidget {
  const RegulationView({Key? key}) : super(key: key);

  @override
  State<RegulationView> createState() => _RegulationViewState();
}

class _RegulationViewState extends State<RegulationView> {
  RegulationBloc regulationBloc = RegulationBloc();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    regulationBloc.fetchResponse();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    var mediaPadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      extendBody: true,
      body: Stack(
        children: [
          ConstantConfig().background,
          Column(
            children: [
              Expanded(
                child: CustomScrollView(
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
                                child: Hero(
                                  tag: "regulation_title",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      'Regulations',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
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
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 12,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: mediaSize.width,
                        child: StreamBuilder<dynamic>(
                          stream: regulationBloc.antDataStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data!.status!) {
                                case Status.initial:
                                  return const SizedBox.shrink();
                                case Status.loading:
                                  List<Widget> shimmer = [];
                                  for (var i = 0; i < 3; ++i) {
                                    shimmer.add(const RegulationShimmerWidget());
                                  }
                                  return Column(
                                    children: shimmer,
                                  );
                                case Status.completed:
                                  RegulationModel responses = snapshot.data!.data as RegulationModel;
                                  List<Widget> regulationRows = [];
                                  if (responses.data!.isNotEmpty) {
                                    for (var item in responses.data!) {
                                      regulationRows.add(
                                        RegulationWidget(data: item),
                                      );
                                    }
                                  } else {
                                    regulationRows.add(const RegulationEmptyWidget());
                                  }
                                  return Column(
                                    children: regulationRows,
                                  );
                                case Status.errror:
                                  return const RegulationErrorWidget();
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
 */