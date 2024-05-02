import 'package:female_health/model/yoga.dart';
import 'package:female_health/screens/poseDetails.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class YogaDetailsScreen extends StatelessWidget {
  final YogaCourse course;

  static const String placeholderImage = 'assets/images/yoga.jpg';

  const YogaDetailsScreen({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isValid = true;

    final filteredPoses =
        course.scheduled.where((pose) => pose.image != null).toList();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(course.name),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          // padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                child: Image.network(course.image,
                    height: 200, width: double.infinity, fit: BoxFit.cover),
              ),
              // const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColor.offwhite,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Featured Yoga Poses:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredPoses.length,
                      itemBuilder: (context, index) {
                        final pose = filteredPoses[index];

                        return GestureDetector(
                          onTap: () {
                            // Navigate to the details screen for this pose
                            // You can pass the pose object to the details screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PoseDetailsScreen(pose: pose),
                              ),
                            );
                          },
                          child: Container(
                            // margin: const EdgeInsets.symmetric(
                            //     vertical: 8, horizontal: 16),
                            // padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              // border:
                              //     Border.all(color: AppColor.yellow, width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Divider(
                                  color: AppColor.yellow.withOpacity(0.3),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            pose.sanskritName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.access_time,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    pose.time,
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(width: 16),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    size: 12,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    pose.category,
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: 100,

                                      // width: double.infinity,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Image.network(
                                          pose.image,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            // Display placeholder image if there is an error loading the image
                                            return Image.asset(
                                              placeholderImage,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // const SizedBox(height: 6),

                                // const SizedBox(height: 4),
                                // const Row(
                                //   children: [],
                                // ),
                                // const SizedBox(height: 8),
                                // const Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
