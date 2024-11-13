import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SliderController extends GetxController {
  var isLoading = true.obs;
  var selectedSliderIndex = 0.obs;
  var sliders = <String>[];

  @override
  void onInit() {
    super.onInit();
    // Simulating a network request for sliders
    Future.delayed(Duration(seconds: 2), () {
      sliders.addAll([
        'https://via.placeholder.com/600x300?text=Slider+1',
        'https://via.placeholder.com/600x300?text=Slider+2',
        'https://via.placeholder.com/600x300?text=Slider+3',
      ]);
      isLoading.value = false;
    });
  }

  void changeSliderIndex(int index) {
    selectedSliderIndex.value = index;
  }
}

class SliderSection extends StatelessWidget {
  const SliderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final sliderController = Get.put(SliderController()); // Initialize SliderController

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * .90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 15,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          // Check if data is still loading
          if (sliderController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          // If there are no sliders available, show fallback content
          if (sliderController.sliders.isEmpty) {
            return Column(
              children: [
                Container(
                  width: size.width * .90,
                  height: 200, // Height for fallback image
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://via.placeholder.com/600x300?text=No+Data'), // Fallback image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotIndicator(isSelected: true), // Show one dot for fallback
                  ],
                ),
              ],
            );
          }

          // If sliders are available, show the actual slider
          return Column(
            children: [
              Container(
                width: size.width * .90,
                height: 200, // Height for actual sliders
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(sliderController.sliders[sliderController.selectedSliderIndex.value]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  sliderController.sliders.length,
                  (index) => GestureDetector(
                    onTap: () => sliderController.changeSliderIndex(index),
                    child: DotIndicator(isSelected: sliderController.selectedSliderIndex.value == index),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isSelected;

  const DotIndicator({super.key, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.blue.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
