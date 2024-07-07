import 'package:female_health/model/yoga.dart';
// import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PoseDetailsScreen extends StatelessWidget {
  final YogaPose pose;

  const PoseDetailsScreen({Key? key, required this.pose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> steps = pose.steps.split('\n');
    return Scaffold(
      appBar: AppBar(
        title: Text(pose.sanskritName),
      ),
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              pose.image,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  ImagePath.appLogo,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
            // const SizedBox(height: 16),
            Transform.translate(
              offset: const Offset(0, -50),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: const BoxDecoration(
                    // color: AppColor.offblack,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${pose.englishName} / ${pose.sanskritName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'What?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pose.description,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Why?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      pose.benefits,
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 16),
                    const Text(
                      'How?',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: steps.length,
                      itemBuilder: (context, index) {
                        int stepNumber = index + 1;
                        return Column(
                          children: [
                            const Divider(),
                            Text('$stepNumber) ${steps[index]}')
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
