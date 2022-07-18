/* import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class YoutubePlayer extends StatefulWidget {
  const YoutubePlayer({Key? key}) : super(key: key);

  @override
  State<YoutubePlayer> createState() => _YoutubePlayerState();
}

class _YoutubePlayerState extends State<YoutubePlayer> {
  
  @override
  void initState() {
    var yt = YoutubeExplode();
  var streamInfo = await yt.videos.streamsClient.getManifest('fRh_vgS2dFE');

  print(streamInfo);

  // Close the YoutubeExplode's http client.
  yt.close();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: Text("asasa"),
    );
  }

}
 */