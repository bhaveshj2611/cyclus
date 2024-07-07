import 'package:female_health/screens/yoga_levels.dart';
import 'package:female_health/screens/yoga_popular.dart';
import 'package:female_health/screens/yogafit.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exercise {
  final String name;
  final String imageUrl;
  final String description;
  final void Function(BuildContext) onTap;

  Exercise(this.name, this.imageUrl, this.description, this.onTap);
}

class ExerciseScreen extends StatelessWidget {
  ExerciseScreen({super.key});

  final List<Exercise> exercises = [
    Exercise('Popular Yoga', 'assets/images/yoga.png',
        'Cleanse your mind and soul with some popular Yoga Poses', (context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const YogaPopularScreen();
        },
      ));
    }),
    Exercise('Yoga with Levels', 'assets/images/stretching.png',
        'Go with Beginner, Intermediate and Advanced Yoga Poses', (context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const YogaLevelsScreen();
        },
      ));
    }),
    Exercise('Body Fitness Yoga', 'assets/images/fit.png',
        'Adopt and improve Physical Fitness with Body Fitness Yoga', (context) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return const YogaFitnessScreen();
        },
      ));
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => exercises[index].onTap(context),
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.offblack.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 4))
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Text(
                              exercises[index].name,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.offblack),
                            ),
                          ),
                          SizedBox(
                            width: 220,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Text(
                                exercises[index].description,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.darkBlue),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          exercises[index].imageUrl,
                          fit: BoxFit.fill,
                          // height: MediaQuery.of(context).size.height / 2,
                          width: 120,
                          // width: double.maxFinite,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
