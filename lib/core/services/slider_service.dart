import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zoc_lms_project/core/models/slider_model.dart';
import 'package:zoc_lms_project/core/utils/appUrls.dart';

class SliderService {
  // Instance member variable to hold the API URL
  final String apiUrl = AppUrls.sliderimage.toString();

  // Constructor to initialize the SliderService if needed
  SliderService();

  // Static method to fetch sliders
  static Future<List<Slider>> fetchSliders() async {
    try {
      // Since `apiUrl` is now non-static, you must create an instance to access it
      final service = SliderService(); // Create instance to access apiUrl
      final response = await http.get(Uri.parse(service.apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => Slider.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load sliders');
      }
    } catch (e) {
      print(
          'Error fetching sliders: $e'); // Print the error for better diagnostics
      rethrow; // Propagate error for the caller to handle
    }
  }
}
