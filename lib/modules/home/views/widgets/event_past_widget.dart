import 'package:flutter/material.dart';

class EventPastWidget extends StatefulWidget {
  const EventPastWidget({Key? key}) : super(key: key);

  @override
  State<EventPastWidget> createState() => _EventPastWidgetState();
}

class _EventPastWidgetState extends State<EventPastWidget> {
  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      height: mediaSize.height,
      color: Colors.green,
    );
  }
}
