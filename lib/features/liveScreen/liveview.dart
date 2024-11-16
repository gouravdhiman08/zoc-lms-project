import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class LiveView extends StatefulWidget {
  final String videoId;
  const LiveView({super.key, required this.videoId});

  @override
  _LiveViewState createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> with WidgetsBindingObserver {
  late YoutubePlayerController _youtubeController;
  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeVideo();
    WidgetsBinding.instance.addObserver(this);
    delay();
  }

  @override
  void dispose() {
    // Dispose the controller safely
    if (_youtubeController.value.isReady) {
      _youtubeController.pause();
      _youtubeController.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Delay the UI state update
  delay() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  // Initialize the YouTube video player
  initializeVideo() {
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        controlsVisibleAtStart: true,
        autoPlay: true,
        mute: false,
        isLive: true,
      ),
    )..addListener(() {
        if (_youtubeController.value.isFullScreen) {
          // Handle full screen mode if necessary
        }
      });
  }

  // Prevent the back button press when in full-screen mode
  Future<bool> _onBackPressed() async {
    if (_youtubeController.value.isFullScreen) {
      // Exit full-screen mode before going back
      _youtubeController.toggleFullScreenMode();
      await Future.delayed(const Duration(milliseconds: 300)); // Wait for full screen exit
      return Future.value(false); // Prevent the default back navigation
    } else {
      if (_youtubeController.value.isPlaying) {
        _youtubeController.pause(); // Pause the video before navigating back
      }
      return Future.value(true); // Allow the default back navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed, // Override back button press
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
          topActions: [
            Container(
              alignment: Alignment.topRight,
              width: Get.width - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_youtubeController.value.isFullScreen)
                    IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          LiveCommentSection(
                            videoId: widget.videoId,
                            isFullScreenMode: _youtubeController.value.isFullScreen,
                          ),
                          enableDrag: true,
                          isScrollControlled: true,
                        );
                      },
                      icon: Icon(
                        Icons.message,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        builder: (context, player) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () async {
                  if (await _onBackPressed()) {
                    Get.offAllNamed('/home', arguments: "Home"); // Navigate back if allowed
                  }
                },
              ),
              backgroundColor: Colors.black,
            ),
            backgroundColor: Colors.white,
            body: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width,
                          height: 290,
                          child: player,
                        ),
                        const SizedBox(height: 10),
                        LiveCommentSection(
                          videoId: widget.videoId,
                          isFullScreenMode: _youtubeController.value.isFullScreen,
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class LiveCommentSection extends StatefulWidget {
  final String videoId;
  final bool isFullScreenMode;

  const LiveCommentSection({
    super.key,
    required this.videoId,
    required this.isFullScreenMode,
  });

  @override
  State<LiveCommentSection> createState() => _LiveCommentSectionState();
}

class _LiveCommentSectionState extends State<LiveCommentSection> {
  List<String> liveCommentList = [];
  TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  // Post a comment and add it to the live comment list
  void postComment(String comment) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    setState(() {
      liveCommentList.insert(0, comment); // Add the comment to the top
    });
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: Colors.white,
        width: widget.isFullScreenMode ? Get.width : Get.width,
        height: widget.isFullScreenMode
            ? MediaQuery.of(context).size.height
            : Get.height / 1.6,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Live Chat",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                hintText: "Add a comment...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      postComment(commentController.text);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 247, 245, 245),
                child: VsScrollbar(
                  controller: scrollController,
                  showTrackOnHover: true,
                  isAlwaysShown: true,
                  style: const VsScrollbarStyle(
                    hoverThickness: 8.0,
                    radius: Radius.circular(10),
                    thickness: 8.0,
                    color: Color.fromARGB(255, 17, 17, 17),
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true, // Make the list start from the bottom
                    itemCount: liveCommentList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(liveCommentList[index]),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

