import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../config/app_colors.dart';
import '../../../consts/app_consts.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String video = '';
  late VideoPlayerController videoPlayerController;
  late Future<void> initializeVideoPlayerFuture;

  void initializeVideo() {
    Map<String, dynamic> data = Get.arguments;
    if (data.containsKey(AppConsts.keyMedia)) {
      video = data[AppConsts.keyMedia];
    }
    if (video != '') {
      videoPlayerController = VideoPlayerController.network(video);
      initializeVideoPlayerFuture = videoPlayerController.initialize();
      videoPlayerController.addListener(checkVideo);
    }
  }

  void checkVideo() {
    if (videoPlayerController.value.position ==
        const Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }

    if (videoPlayerController.value.position ==
        videoPlayerController.value.duration) {
      print('video Ended');
      // setState(() {
      //   videoPlayerController.initialize();
      // });
    }
  }

  @override
  void initState() {
    initializeVideo();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
            child: FutureBuilder(
          future: initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  AspectRatio(
                    aspectRatio: videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (videoPlayerController.value.isPlaying) {
                                videoPlayerController.pause();
                              } else {
                                videoPlayerController.play();
                              }
                            });
                          },
                          icon: Icon(
                            videoPlayerController.value.isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            size: 32.0,
                            color: AppColors.kPrimaryColor,
                          ),
                        )),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )),
      ),
    );
  }
}
