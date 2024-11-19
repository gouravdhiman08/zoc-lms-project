import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:zoc_lms_project/features/liveScreen/widgets/live_comments.dart';

// The live video view screen
class LiveView extends StatefulWidget {
  final String videoId;
  const LiveView({super.key, required this.videoId});

  @override
  _LiveViewState createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> with WidgetsBindingObserver {
  late YoutubePlayerController _youtubeController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeVideo();
    WidgetsBinding.instance.addObserver(this);
    delay();
  }

  @override
  void dispose() {
    _youtubeController.pause();
    _youtubeController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  delay() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  initializeVideo() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        controlsVisibleAtStart: true,
        autoPlay: true,
        mute: false,
        isLive: true,
      ),
    );
  }

  Future<bool> _onBackPressed() async {
    if (_youtubeController.value.isFullScreen) {
      _youtubeController.toggleFullScreenMode();
      return Future.value(false); // Prevent the default back navigation
    } else {
      if (_youtubeController.value.isPlaying) {
        _youtubeController.pause();
      }
      return Future.value(true); // Allow the default back navigation
    }
  }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: _youtubeController,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.blueAccent,
//           bottomActions: [
//             CurrentPosition(),
//             ProgressBar(isExpanded: true),
//             RemainingDuration(),
//           ],
//           aspectRatio: 16 / 9,
//         ),
//         builder: (context, player) => GestureDetector(
//           onTap: () {
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           child: Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//                 onPressed: () async {
//                   if (await _onBackPressed()) {
//                     Get.offAllNamed('/home', arguments: "Home");
//                   }
//                 },
//               ),
//               backgroundColor: Colors.black,
//             ),
//             backgroundColor: Colors.white,
//             body: isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize
//                           .min, // Ensures the column only takes as much space as its children
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           width: Get.width,
//                           height: 290, // Fixed height for the player
//                           child: player,
//                         ),
//                         const SizedBox(height: 10),
//                         // Use a Container to limit the height of LiveChat
//                         Container(
//                           height: 400, // Set a fixed height or use constraints
//                           child: Expanded(
//                             child: LiveChat(
//                               courseId: "course123",
//                               videoId: widget.videoId,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }
// }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          bottomActions: [
            CurrentPosition(),
            ProgressBar(isExpanded: true),
            RemainingDuration(),
          ],
          aspectRatio: 16 / 9,
        ),
        builder: (context, player) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () async {
                  if (await _onBackPressed()) {
                    Get.offAllNamed('/home', arguments: "Home");
                  }
                },
              ),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.white,
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: 290, // Fixed height for the player
                        child: player,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: LiveChat(
                          courseId: "course123", // Replace with actual courseId
                          videoId: widget.videoId,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
