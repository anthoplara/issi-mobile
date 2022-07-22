import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/modules/profile/blocs/profile_inactive_bloc.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:mobile/utils/networks/config/constant_config.dart';
import 'package:mobile/utils/networks/key_storage.dart';
import 'package:override_text_scale_factor/override_text_scale_factor.dart';
import 'package:shimmer/shimmer.dart';

class ProfileDeleteWidget extends StatefulWidget {
  final Function callback;
  const ProfileDeleteWidget({Key? key, required this.callback}) : super(key: key);

  @override
  State<ProfileDeleteWidget> createState() => _ProfileDeleteWidgetState();
}

class _ProfileDeleteWidgetState extends State<ProfileDeleteWidget> {
  ProfileInactiveBloc profileInactiveBloc = ProfileInactiveBloc();
  GetStorage localData = GetStorage();

  bool hadFeedback = false;

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
    return Center(
      child: StreamBuilder<dynamic>(
        stream: profileInactiveBloc.antDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status!) {
              case Status.initial:
                return activeButton();
              case Status.loading:
                return shimmerButton();
              case Status.completed:
                if (!hadFeedback) {
                  Timer(const Duration(milliseconds: 10), () {
                    widget.callback(true);
                  });
                  hadFeedback = true;
                }
                return shimmerButton();
              case Status.errror:
                return shimmerButton();
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget shimmerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 23.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 14,
          width: 120,
          color: Colors.grey[200],
        ),
      ),
    );
  }

  Widget activeButton() {
    return BouncingButtonHelper(
      width: 160,
      color: Colors.transparent,
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
                  "Apakah anda yakin akan menghapus akun?",
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
                      "Ya, Hapus!",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: "Google-Sans",
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      profileInactiveBloc.fetchResponse(localData.read(KeyStorage.userName) ?? "0");
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
          "Delete your Account",
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: "Google-Sans",
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
