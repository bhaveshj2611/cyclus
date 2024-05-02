import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/screens/profile.dart';
import 'package:female_health/screens/yoga_levels.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  late List<Widget> _pages = [
    // Example sliding info
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Next Start Date of Period",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Predicting...",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Days until Fertile",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Predicting...",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    // const Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Text(
    //         "Current Day of the Cycle",
    //         style: TextStyle(fontSize: 20),
    //       ),
    //       Text(
    //         "Predicting...",
    //         style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    //       ),
    //     ],
    //   ),
    // ),
    const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Days until Ovulation",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "Predicting...",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),

    // Add more pages as needed
  ];

  String userFName = '';
  String userHeight = '';
  String userWeight = '';
  int userCycle = 0;
  String startDate = '';
  String endDate = '';

  int currentDayOfCycle(String startDate, String endDate) {
    DateTime currentDate = DateTime.now();
    DateTime cycleStartDate = DateTime.parse(startDate);
    DateTime cycleEndDate = DateTime.parse(endDate);

    if (currentDate.isBefore(cycleStartDate)) {
      return 0;
    }

    if (currentDate.isAfter(cycleEndDate)) {
      return 0;
    }

    int difference = currentDate.difference(cycleStartDate).inDays;
    return difference + 1;
  }

  int daysUntilFertile(int cycleLength, int currentDay) {
    int ovulationDay = cycleLength - 14;
    int fertileStart = ovulationDay - 4;
    int fertileEnd = ovulationDay;

    if (currentDay <= fertileEnd && currentDay >= fertileStart) {
      return 0;
    } else if (currentDay < fertileStart) {
      return fertileStart - currentDay;
    } else {
      return 0;
    }
  }

  Future<void> fetchUserData() async {
    // isLoading = true;
    try {
      // print('pehla');
      // setState(() {
      //   isLoading = true;
      // });

      // Get current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;
      // print('dusra');
      // Fetch user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      // print('teesra');

      // Access user data from the document
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        // print('chautha');
        // Update UI with user data
        if (mounted) {
          setState(() {
            // Assuming the fields are 'name', 'height', 'weight', 'age'
            // Replace these with your actual field names from Firestore
            userFName = userData['FirstName'] ?? 'First Name';
            // userLName = userData['LastName'] ?? 'Last Name';
            userHeight = userData['Height'] ?? '180cm';
            userWeight = userData['Weight'] ?? '70kg';
            // userDob = userData['DateOfBirth'] ?? '22';
            userCycle = userData['AvgCycle'] ?? 28;
            startDate = userData['StartDate'] ?? '22';
            endDate = userData['EndDate'] ?? '22';

            // userAge = calculateAge(userDob);
            // periodLength = calculateDaysBetween(startDate, endDate);

            // print(userFName);
            // print(userLName);
            // print(userHeight);
            // print(userWeight);
            // print(userCycle);
            // print(startDate);
            // print(endDate);

            // print(periodLength);
            // print(userDob);
          });
        }
        sendUserDataToAPI();
        // setState(() {
        //   isLoading = false;
        // });
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  int kgToLbs(String userWeight) {
    try {
      int w = int.parse(userWeight);
      return (w * 2.20462).round();
    } catch (e) {
      print('Error parsing weight: $e');
      return 0;
    }
  }

  int cmToInches(String userHeight) {
    try {
      int h = int.parse(userHeight);
      return (h * 0.393701).round();
    } catch (e) {
      print('Error parsing height: $e');
      return 0;
    }
  }

  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat.yMMMMd().format(date);
    return formattedDate;
  }

// Function to calculate the number of days between two dates
  int daysBetweenDates(String date1) {
    DateTime formDate = DateTime.parse(date1);
    final difference = formDate.difference(DateTime.now()).inDays;
    return difference;
  }

  Future<void> sendUserDataToAPI() async {
    // API endpoint URL
    const String apiUrl =
        'https://cyclus-female-health.onrender.com/predict_ovulation';

    int newWeight = kgToLbs(userWeight);
    int newHeight = cmToInches(userHeight);

    // Prepare the data to send to the API
    Map<String, dynamic> data = {
      "weight": newWeight, // Convert kg to lbs
      "height": newHeight, // Convert cm to inches
      "length_of_cycle": userCycle,
      "start_date_of_last_period": startDate,
      "end_date_of_last_period": endDate,
      "unusual_bleeding": 0,
    };

    try {
      // Make POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the response data
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // int ovulationDay = responseData['estimated_day_of_ovulation'];
        String nextPeriodDate = responseData['next_start_date_of_period'];
        // Print or use responseData as needed
//         Map<String, dynamic> apiResponse = {
//   "estimated_day_of_ovulation":,
//   "next_start_date_of_period": "2024-05-07"
// };
        print(responseData);
        String formattedDate = formatDate(nextPeriodDate);
        int ovDays = daysBetweenDates(nextPeriodDate);
        int currentDayofCycle = currentDayOfCycle(startDate, endDate);
        int daysUF = daysUntilFertile(userCycle, currentDayofCycle);
        Widget ovulationDayWidget = Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Days until Ovulation",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "$ovDays",
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
        // Widget currDay = Center(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       const Text(
        //         "Current Day of the Cycle",
        //         style: TextStyle(fontSize: 18),
        //       ),
        //       Text(
        //         "$currentDayofCycle",
        //         style:
        //             const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        //       ),
        //     ],
        //   ),
        // );
        Widget daysUFertile = Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Days until Fertile",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "$daysUF",
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );

        Widget nextPeriodWidget = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Next Start Date of Period",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                formattedDate,
                style:
                    const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );

        // Update _pages list with new widgets
        setState(() {
          _pages = [
            nextPeriodWidget,
            // currDay,
            daysUFertile,
            ovulationDayWidget,

            // Add more pages as needed
          ];
        });
      } else {
        // If request fails, throw an error
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image positioned at bottom left
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset(
                'assets/images/3.png',
                width: 150,
                // height: 150,
                fit: BoxFit.cover,
              ),
            ),
            // Background image positioned at top right
            // Positioned(
            //   // right: 0,
            //   // height: 600,/
            //   top: 0,
            //   child: Image.asset(
            //     'assets/images/bg.png',
            //     // width: 150,
            //     // height: 150,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              // color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello $userFName',
                              style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'How are you today?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              // isDismissible: false,
                              // enableDrag: false,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return const Profile();
                              },
                            );
                          },
                          child: Image.asset(
                            ImagePath.appLogo,
                            width: 60,
                          ),
                        )
                      ],
                    ),
                  ),
                  // const SizedBox(
                  //   height: 200,
                  // ),
                  Expanded(
                    child: Center(
                      child: Stack(
                        children: [
                          // Outer circle
                          const Center(
                            child: CircleAvatar(
                              backgroundColor: AppColor.orange,
                              radius: 180,
                            ),
                          ),
                          // Middle circle
                          const Center(
                            child: CircleAvatar(
                              backgroundColor: AppColor.yellow,
                              radius: 160,
                            ),
                          ),
                          // Inner circle
                          Center(
                            child: CircleAvatar(
                              backgroundColor: AppColor.offwhite,
                              radius: 140,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PageView(
                                      controller: _pageController,
                                      children: _pages,
                                    ),
                                  ),
                                  SmoothPageIndicator(
                                    controller: _pageController,
                                    count: _pages.length,
                                    effect: const WormEffect(
                                      dotHeight: 8,
                                      dotWidth: 8,
                                      activeDotColor: AppColor.orange,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
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
  }
}
