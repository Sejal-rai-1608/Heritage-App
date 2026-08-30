import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'onboarding_screen.dart';

class SplashVideoScreen extends StatefulWidget {
  const SplashVideoScreen({super.key});

  @override
  State<SplashVideoScreen> createState() => _SplashVideoScreenState();
}

class _SplashVideoScreenState extends State<SplashVideoScreen> {
  VideoPlayerController? _controller;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/great_perfectkeep_as_it_is_j.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown and play the video
        if (mounted) setState(() {});
        _controller?.play();
      });

    _controller?.addListener(() {
      final controller = _controller;
      if (controller != null &&
          controller.value.isInitialized &&
          !controller.value.isPlaying &&
          controller.value.position >= controller.value.duration &&
          !_navigated) {
        _navigated = true;
        // Navigate to the onboarding screen when the video finishes
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    return Scaffold(
      backgroundColor: Colors.black, // Typical background for a video splash
      body: Center(
        child: (controller != null && controller.value.isInitialized)
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
            : const CircularProgressIndicator(color: Colors.white), // Loading state
      ),
    );
  }
}
