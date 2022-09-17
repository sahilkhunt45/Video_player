import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../global.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  List<VideoPlayerController> controller = [];
  List<ChewieController> chewieController = [];

  List Videos = [];
  List networkVideos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Videos = Global.data.videos;

      for (var e in Videos) {
        controller.add(VideoPlayerController.asset(e)
          ..initialize().then(
            (_) {
              setState(() {});
            },
          ));
      }

      for (var e in controller) {
        chewieController.add(ChewieController(
          videoPlayerController: e,
          autoPlay: false,
          looping: false,
        ));
        setState(() {});
      }

      Timer.periodic(const Duration(microseconds: 200), (timer) {
        setState(() {});
      });
    });
  }

  Widget build(BuildContext context) {
    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.2),
      appBar: AppBar(
        title: Text(res.type),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ...Videos.map(
              (e) => AspectRatio(
                aspectRatio: controller[Videos.indexOf(e)].value.aspectRatio,
                child: Chewie(
                  controller: chewieController[Videos.indexOf(e)],
                ),
              ),
            ).toList(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var e in controller) {
      chewieController[controller.indexOf(e)].dispose();
      e.dispose();
    }
    super.dispose();
  }
}
