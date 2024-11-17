
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/models/slider_model.dart' as SliderModel;
import 'package:zoc_lms_project/core/services/slider_service.dart';

class SliderController extends GetxController {
  var sliders = <SliderModel.Slider>[].obs; // Observable list of sliders
  var isLoading = false.obs; // Observable loading state
  var selectedSliderIndex = 0.obs; // Observable index for the current slider

  // Constructor for dependency injection
  SliderController();

  @override
  void onInit() {
    super.onInit();
    fetchSliders();
  }

  // Fetch sliders from the service
  Future<void> fetchSliders() async {
    isLoading.value = true;
    try {
      List<SliderModel.Slider> sliderList =
          await SliderService.fetchSliders(); // Fetch sliders
      // Filter only active sliders
      sliders.value = sliderList
          .where((slider) => slider.isActive)
          .toList(); // Only add active sliders
    } catch (e) {
      // Handle error (you might want to show an error message here)
      print('Error fetching sliders: $e');
    } finally {
      isLoading.value = false; // Set loading to false after the request
    }
  }

  // Update the selected slider index
  void changeSliderIndex(int index) {
    selectedSliderIndex.value = index;
  }
}
