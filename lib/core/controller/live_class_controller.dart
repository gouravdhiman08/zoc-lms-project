import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zoc_lms_project/core/models/live_model.dart';
import 'package:zoc_lms_project/core/utils/appUrls.dart';

class LiveClassController extends GetxController {
  var isLiveClassStarted = false.obs;
  var error = ''.obs;
  var video = Rxn<LiveVideo>();
  var isFetchingCourses = false.obs;
  var selectedCourseId = ''.obs;

  Future<void> fetchLiveVideo(String id) async {
    isFetchingCourses(true);
    error('');

    try {
      final response =
          await http.get(Uri.parse('${AppUrls.fetchlive}?courseId=$id'));
      print("API Response: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Decoded Data: $data");

        if (data is Map<String, dynamic> && data['success'] == true) {
          final liveClassData = data['data'];
          if (liveClassData is Map<String, dynamic>) {
            try {
              video.value = LiveVideo.fromJson(liveClassData);
              isLiveClassStarted.value = video.value?.isLive ?? false;
            } catch (e) {
              print("Error parsing video data: $e");
              error.value = 'Unable to load live class data';
              isLiveClassStarted.value = false;
            }
          } else {
            error.value = 'No live class is currently available';
            isLiveClassStarted.value = false;
          }
        } else {
          error.value = 'No live class data available';
          isLiveClassStarted.value = false;
        }
      } else {
        error.value = 'Failed to fetch live class data. Please try again.';
        isLiveClassStarted.value = false;
      }
    } catch (e) {
      print("Error fetching live video: $e");
      error.value =
          'Unable to load live class. Please check your connection and try again.';
      isLiveClassStarted.value = false;
    } finally {
      isFetchingCourses(false);
    }
  }
}
