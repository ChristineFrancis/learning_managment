import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:learning_managment_system/core/constant/color.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
   final String url;
   final String description;
  VideoPage( {super.key, required this.url, required this.description});

  @override
  _SamplePlayerState createState() => _SamplePlayerState(url: this.url, description: this.description);
}

class _SamplePlayerState extends State<VideoPage> {
  final String url;
  final String description;
  late FlickManager flickManager;

  _SamplePlayerState({required this.description, required this.url});
  @override
  void initState() {
    print('Videooooooooooo url $url');
    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.networkUrl(
            Uri.parse(url),)
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(description),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,),
      body: AspectRatio(
        aspectRatio: 16/9,
        child: FlickVideoPlayer(
          flickManager: flickManager
        ),
      ),
    );
  }
}