import 'dart:convert';

import 'package:female_health/controller/loading_provider.dart';
import 'package:female_health/model/yoga.dart';
import 'package:female_health/screens/yogaDetails.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class YogaLevelsScreen extends StatefulWidget {
  const YogaLevelsScreen({super.key});

  @override
  State<YogaLevelsScreen> createState() => _YogaLevelsScreenState();
}

class _YogaLevelsScreenState extends State<YogaLevelsScreen> {
  static const String placeholderImage = 'assets/images/yoga.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yoga Courses'),
      ),
      body: FutureBuilder<List<YogaCourse>>(
        future: fetchData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            final List<YogaCourse> courses = snapshot.data!;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      navToCourse(context, course);
                    },
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.yellow, width: 3),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.offblack.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 0),
                          )
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(28)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: SizedBox(
                              width: 160,
                              child: Text(
                                capFirst(course.name),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.offblack,
                                ),
                              ),
                            ),
                          ),
                          // const SizedBox(width: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              course.image,
                              fit: BoxFit.fill,
                              height: 140,
                              width: 162.72,
                              errorBuilder: (context, error, stackTrace) {
                                // Display placeholder image if there is an error loading the image
                                return Image.asset(
                                  placeholderImage,
                                  fit: BoxFit.fill,
                                  height: 140,
                                  width: 162.72,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox(); // Placeholder
          }
        },
      ),
    );
  }
}

Future<List<YogaCourse>> fetchData(BuildContext context) async {
  // LoadingProvider loadingProvider =
  // Provider.of<LoadingProvider>(context, listen: false);
  // loadingProvider.setLoading(true);
  // setState(() {
  //   isLoading = true;
  // });
  const url = 'https://priyangsubanerjee.github.io/yogism/yogism-api.json';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['yoga-levels'];
      final courses = jsonData
          .map((courseJson) => YogaCourse.fromJson(courseJson))
          .toList();
      // Set loading to false after data is fetched
      // setState(() {
      //   isLoading = false;
      // });
      return courses;
    } else {
      // Set loading to false on error
      // setState(() {
      //   isLoading = false;
      // });
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    // setState(() {
    //   isLoading = false;
    // });
    throw Exception('Error fetching data');
  }
  // setState(() {
  //   isLoading = false;
  // });
}

String capFirst(String input) {
  List<String> words = input.split(' ');
  List<String> capitalizedWords = words.map((word) {
    if (word.isEmpty) {
      return word; // Handle empty strings if needed
    }
    return word[0].toUpperCase() + word.substring(1);
  }).toList();
  return capitalizedWords.join(' ');
}

void navToCourse(BuildContext context, YogaCourse course) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => YogaDetailsScreen(
        course: course,
      ),
    ),
  );
}
