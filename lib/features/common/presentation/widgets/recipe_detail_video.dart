import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class RecipeDetailVideo extends StatefulWidget {
  const RecipeDetailVideo({
    super.key,
    required this.videoUrl,
  });

  final String videoUrl;

  @override
  State<RecipeDetailVideo> createState() => _RecipeDetailVideoState();
}

class _RecipeDetailVideoState extends State<RecipeDetailVideo> {
  late final VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    controller.initialize().then(
          (value) => setState(
            () {
              controller.play();
            },
          ),
        );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                  } else {
                    controller.play();
                  }
                },
                child: VideoPlayer(controller),
              ),
              Positioned(
                bottom: 40,
                right: 0,
                left: 0,
                child: SizedBox(
                  child: VideoProgressIndicator(controller, allowScrubbing: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
