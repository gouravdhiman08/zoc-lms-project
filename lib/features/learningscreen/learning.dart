import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/controller/live_class_controller.dart';
import 'package:zoc_lms_project/core/services/enrolled_course_service.dart';
import 'package:zoc_lms_project/features/liveScreen/liveview.dart';

class LearningScreen extends StatefulWidget {
  final String courseId;

  const LearningScreen({super.key, required this.courseId});

  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late Future<Map<String, dynamic>> _courseDetails;
  bool _isLoading = false;
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadCourseDetails();
  }

  Future<void> _loadCourseDetails() async {
    setState(() => _isLoading = true);
    try {
      _courseDetails =
          EnrolledCoursesService().fetchCoursebyid(widget.courseId);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load course: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleDelete() async {
    setState(() => _isLoading = true);
    try {
      // Add actual delete API call here
      await Future.delayed(Duration(seconds: 1)); // Simulate API call

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete course: $error'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildCourseHeader(Map<String, dynamic> course) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              course['title'] ?? 'No Title',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 8),
            Text(
              course['description'] ?? 'No Description',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 16),
            _buildCourseStats(course),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseStats(Map<String, dynamic> course) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildVideosList(List<dynamic> videos) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: videos.length,
            separatorBuilder: (context, index) => Divider(height: 1),
            itemBuilder: (context, index) {
              final video = videos[index];
              final isCurrentVideo = index == _currentVideoIndex;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isCurrentVideo
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                  child: Text('${index + 1}'),
                ),
                title: Text(
                  video['title'],
                  style: TextStyle(
                    fontWeight:
                        isCurrentVideo ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(video['duration'] ?? 'Duration not specified'),
                trailing: Icon(Icons.play_circle_outline),
                selected: isCurrentVideo,
                onTap: () {
                  setState(() => _currentVideoIndex = index);
                  _launchURL(video['url']);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<Map<String, dynamic>>(
              future: _courseDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 48, color: Colors.red),
                        SizedBox(height: 16),
                        Text('Error: ${snapshot.error}'),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loadCourseDetails,
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text('No course details available.'),
                  );
                }

                final course = snapshot.data!;
                final videos = course['videos'] ?? [];

                return RefreshIndicator(
                  onRefresh: _loadCourseDetails,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            final liveClassController =
                                Get.put(LiveClassController());

                            await liveClassController
                                .fetchLiveVideo(widget.courseId);

                            if (liveClassController.error.isEmpty) {
                              _launchURL(
                                  liveClassController.video.value?.url ?? '');
                            } else {
                              // Show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text(liveClassController.error.value)),
                              );
                            }
                          },
                          child: Text(
                            "Live Class",
                            style: TextStyle(color: Colors.red),
                          )),
                      SizedBox(height: 16),
                      if (videos.isNotEmpty)
                        _buildVideosList(videos)
                      else
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(
                              child: Text(
                                'No videos available for this course.',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _launchURL(String url) {
    String videoId;

    if (url.contains('youtube.com/watch?v=')) {
      videoId = url.split('v=')[1].split('&')[0];
    } else if (url.contains('youtu.be/')) {
      videoId = url.split('youtu.be/')[1];
    } else {
      print('Invalid URL format');
      return; // Early return if the URL format is invalid
    }
    // Navigate to the LiveView page, passing the video ID
    Get.to(() => LiveView(videoId: videoId));
  }
}
