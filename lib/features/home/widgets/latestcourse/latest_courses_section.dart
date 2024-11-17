import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoc_lms_project/core/controller/home_controller.dart';
import 'package:zoc_lms_project/core/utils/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:zoc_lms_project/features/checkout/CheckoutScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zoc_lms_project/features/home/widgets/viewall.dart';

class LatestCoursesSection extends StatelessWidget {
  const LatestCoursesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController()); // Instantiate HomeController

    // Trigger loading courses when the widget is first built
    controller.loadFeaturedCourses();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Latest Courses',
            ),
            GestureDetector(
              onTap: () {
                Get.to(ViewAll());
              },
              child: Text(
                'View All',
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),

        // Use Obx to listen for updates to featuredCourses
        Obx(() {
          if (controller.featuredCourses.isEmpty) {
            // Display a loading indicator while courses are being fetched
            // return const Center(child: CircularProgressIndicator());
            return SpinKitFadingCircle(
              // Modern loading spinner
              color: AppColors.primary, // Set color to your theme
              size: 50.0, // Adjust size of the spinner
            );
          }

          return AlignedGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            itemCount: controller.featuredCourses.length,
            itemBuilder: (ctx, index) {
              final data = controller.featuredCourses[index];

              return SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      // Course Image (Thumbnail)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Course Title
                            Text(
                              data.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.8),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),

                            // Course Description (Shortened)
                            Text(
                              data.description ?? 'No description available',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),

                            // Price Display (Course Cost)
                            Text(
                              '₹${data.cost}',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Creator Name
                            Text(
                              'By ${data.createdBy.name}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Buy Now Button
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Get.to(() => LiveView(
                                  //     videoId:
                                  //         "AbZCfDiRURA")); // Assuming data.videoId exists
                                  Get.to(() => CheckoutScreen(data: data));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    'Checkout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          );
        }),
      ],
    );
  }
}
