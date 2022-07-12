import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';

class RegulationDetailView extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const RegulationDetailView({Key? key, required this.categoryId, required this.categoryName}) : super(key: key);

  @override
  State<RegulationDetailView> createState() => _RegulationDetailViewState();
}

class _RegulationDetailViewState extends State<RegulationDetailView> {
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
          ConstantConfig().background,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 6.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Hero(
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
                                    Text(
                                      widget.categoryName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Google-Sans",
                                      ),
                                    ),
                                  ],
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
                          onTap: () async {},
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
                          onTap: () async {},
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
                          onTap: () async {},
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
                                      'assets/images/icons/pin.png',
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
