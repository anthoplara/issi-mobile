import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

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
                                  tag: "search_title",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      'Search',
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
