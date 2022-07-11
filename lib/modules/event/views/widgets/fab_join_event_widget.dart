import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/utils/helpers/bouncing_button.dart';
import 'package:mobile/utils/networks/api_response.dart';
import 'package:shimmer/shimmer.dart';

import '../../blocs/join_event_bloc.dart';

class FabJoinEventWidget extends StatefulWidget {
  final String dataId;
  final Function callback;
  const FabJoinEventWidget({Key? key, required this.dataId, required this.callback}) : super(key: key);

  @override
  State<FabJoinEventWidget> createState() => _FabJoinEventWidgetState();
}

class _FabJoinEventWidgetState extends State<FabJoinEventWidget> {
  JoinEventBloc joinEventBloc = JoinEventBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: joinEventBloc.antDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data!.status!) {
            case Status.initial:
              return joinActive();
            case Status.loading:
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[200]!,
                child: Container(
                  width: 220,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.grey[300]!,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              );
            case Status.completed:
              if ((snapshot.data!.data ?? "0") == "1") {
                widget.callback("1");
              } else {}
              return joinActive();
            case Status.errror:
              return joinActive();
          }
        }
        return Container();
      },
    );
  }

  Widget joinActive() {
    return BouncingButtonHelper(
      width: 220,
      height: 54,
      color: const Color(0xff222222),
      onTap: () async {
        (await showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => BackdropFilter(
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
                "Apakah anda yakin akan daftar event ini?",
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
                    "Ya, Daftar!",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: "Google-Sans",
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    joinEventBloc.fetchResponse(widget.dataId);
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
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: const [
            Expanded(
              child: Center(
                child: Text(
                  "JOIN EVENT",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Google-Sans",
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.orange,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 14,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
