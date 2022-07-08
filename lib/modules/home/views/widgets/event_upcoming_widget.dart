import 'package:flutter/material.dart';

class EventUpcomingWidget extends StatefulWidget {
  const EventUpcomingWidget({Key? key}) : super(key: key);

  @override
  State<EventUpcomingWidget> createState() => _EventUpcomingWidgetState();
}

class _EventUpcomingWidgetState extends State<EventUpcomingWidget> {
  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      height: mediaSize.height,
      color: Colors.red,
    );
  }
}
