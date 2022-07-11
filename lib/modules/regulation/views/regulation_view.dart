import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

import 'regulation_list_view.dart';

class RegulationView extends StatelessWidget {
  const RegulationView({Key? key}) : super(key: key);

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
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: BouncingButtonHelper(
                          autoWidth: true,
                          autoHeight: true,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                          onTap: () async {
                            Get.to(
                              const RegulationListView(
                                categoryId: 1,
                                categoryName: "Produk Hukum",
                              ),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffff2e9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/icons/balance_sheet.png',
                                    ),
                                    width: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Produk Hukum",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Google-Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: BouncingButtonHelper(
                          autoWidth: true,
                          autoHeight: true,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                          onTap: () async {
                            Get.to(
                              const RegulationListView(
                                categoryId: 2,
                                categoryName: "Regulasi Internasional",
                              ),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffff2e9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/icons/world.png',
                                    ),
                                    width: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Regulasi Internasional",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Google-Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
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
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: BouncingButtonHelper(
                          autoWidth: true,
                          autoHeight: true,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                          onTap: () async {
                            Get.to(
                              const RegulationListView(
                                categoryId: 3,
                                categoryName: "Regulasi Nasional",
                              ),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffff2e9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/icons/pin_active.png',
                                    ),
                                    width: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Regulasi Nasional",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Google-Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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

/* class RegulationView extends StatefulWidget {
  const RegulationView({Key? key}) : super(key: key);

  @override
  State<RegulationView> createState() => _RegulationViewState();
}

class _RegulationViewState extends State<RegulationView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        child: BouncingButtonHelper(
                          autoWidth: true,
                          autoHeight: true,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                          onTap: () async {
                            Get.to(
                              const RegulationListView(
                                categoryId: 1,
                                categoryName: "Produk Hukum",
                              ),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffff2e9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/icons/balance_sheet.png',
                                    ),
                                    width: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Produk Hukum",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Google-Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        child: BouncingButtonHelper(
                          autoWidth: true,
                          autoHeight: true,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                          onTap: () async {
                            Get.to(
                              const RegulationListView(
                                categoryId: 2,
                                categoryName: "Regulasi Internasional",
                              ),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffff2e9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/icons/world.png',
                                    ),
                                    width: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Regulasi Internasional",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Google-Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
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
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 22,
                        ),
                        child: BouncingButtonHelper(
                          autoWidth: true,
                          autoHeight: true,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(0),
                          onTap: () async {
                            Get.to(
                              const RegulationListView(
                                categoryId: 3,
                                categoryName: "Regulasi Nasional",
                              ),
                              transition: Transition.fadeIn,
                              duration: const Duration(milliseconds: 400),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffff2e9),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/images/icons/pin_active.png',
                                    ),
                                    width: 22.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Regulasi Nasional",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontFamily: "Google-Sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
} */
