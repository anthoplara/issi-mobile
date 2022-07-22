import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/modules/startup/views/splash_screen_view.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';
import 'package:mobile/utils/networks/key_storage.dart';
import 'package:override_text_scale_factor/override_text_scale_factor.dart';
import 'package:shimmer/shimmer.dart';

import 'widgets/profile_delete_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  GetStorage localData = GetStorage();
  String userImage = "";

  @override
  void initState() {
    userImage = localData.read(KeyStorage.userImage) ?? "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void deleteCallback(bool status) {
    if (status) {
      localData.write(KeyStorage.userId, "0");
      Get.offAll(
        const SplashscreenView(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 400),
      );
    }
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
          CustomScrollView(
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
                          'Profile',
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 53,
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFf37501),
                            radius: 52,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(52),
                              child: SizedBox(
                                height: 104,
                                width: 104,
                                child: userImage != ""
                                    ? CachedNetworkImage(
                                        imageUrl: userImage,
                                        placeholder: (context, url) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[200]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              height: 104,
                                              width: 104,
                                              color: Colors.grey[200],
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Container(
                                            height: 104,
                                            width: 104,
                                            color: Colors.grey[200],
                                            child: const Center(
                                              child: Icon(Icons.error),
                                            ),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      )
                                    : const Center(
                                        child: Image(
                                          image: AssetImage(
                                            'assets/images/profile-default.png',
                                          ),
                                          width: 64.0,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          localData.read(KeyStorage.userFullName),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: "Google-Sans",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      /* Center(
                        child: BouncingButtonHelper(
                          width: 160,
                          color: Colors.white,
                          border: Border.all(
                            width: 1.0,
                            color: const Color(0xFFf37501),
                          ),
                          onTap: () async {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.edit,
                                  size: 26,
                                  color: Color(0xFFf37501),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: "Google-Sans",
                                        color: Color(0xFFf37501),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ), */
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: const Color(0xFFf37501).withOpacity(0.1),
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: const Color(0xFFf37501).withOpacity(0.1),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 22,
                        ),
                        itemList("Fullname", localData.read(KeyStorage.userFullName) ?? "-"),
                        itemList("Address", localData.read(KeyStorage.userAddress) ?? "-"),
                        itemList("Phone", localData.read(KeyStorage.userPhone) ?? "-"),
                        itemList("Email", localData.read(KeyStorage.userEmail) ?? "-"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: Text(
                            'About Me',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Google-Sans",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: HtmlWidget(
                            localData.read(KeyStorage.userDescription) ?? "-",
                            textStyle: TextStyle(
                              fontSize: 14.0,
                              fontFamily: "Google-Sans",
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      Center(
                        child: BouncingButtonHelper(
                          width: 160,
                          color: Colors.black,
                          onTap: () async {
                            (await showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) => OverrideTextScaleFactor(
                                textScaleFactor: ConstantConfig().textScale,
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                                  child: CupertinoActionSheet(
                                    title: Text(
                                      "Konfirmasi",
                                      style: TextStyle(
                                        color: Colors.grey[900]!,
                                        fontSize: 16.0,
                                        fontFamily: "Google-Sans",
                                      ),
                                    ),
                                    message: Text(
                                      "Apakah anda yakin akan keluar akun?",
                                      style: TextStyle(
                                        color: Colors.grey[900]!,
                                        fontSize: 14.0,
                                        fontFamily: "Google-Sans",
                                      ),
                                    ),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        isDefaultAction: true,
                                        child: const Text(
                                          "Ya, Keluar!",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: "Google-Sans",
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop(false);
                                          localData.write(KeyStorage.userId, "0");
                                          Get.offAll(
                                            const SplashscreenView(),
                                            transition: Transition.fadeIn,
                                            duration: const Duration(milliseconds: 400),
                                          );
                                        },
                                      )
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      isDestructiveAction: true,
                                      child: const Text(
                                        "Tidak",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontFamily: "Google-Sans",
                                        ),
                                      ),
                                      onPressed: () => Navigator.of(context).pop(false),
                                    ),
                                  ),
                                ),
                              ),
                            ));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            child: Text(
                              "LOGOUT",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: "Google-Sans",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    const Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Google-Sans",
                        color: Colors.black,
                      ),
                    ),
                    ProfileDeleteWidget(callback: deleteCallback),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: mediaPadding.bottom + 55,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget itemList(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: "Google-Sans",
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "Google-Sans",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
