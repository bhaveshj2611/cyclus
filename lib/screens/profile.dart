import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/screens/sign_in.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_gradient.dart';
import 'package:female_health/widgets/appBar.dart';
import 'package:female_health/widgets/round_button.dart';
import 'package:female_health/widgets/setting_row.dart';
import 'package:female_health/widgets/title_subtitle_cell.dart';
import 'package:female_health/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toast/toast.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool positive = false;

  List accountArr = [
    {"image": "assets/logo/appLogo.png", "name": "Personal Data", "tag": "1"},
    {"image": "assets/logo/appLogo.png", "name": "Achievement", "tag": "2"},
    {
      "image": "assets/logo/appLogo.png",
      "name": "Activity History",
      "tag": "3"
    },
    {"image": "assets/logo/appLogo.png", "name": "Workout Progress", "tag": "4"}
  ];

  List otherArr = [
    {"image": "assets/logo/appLogo.png", "name": "Period Length", "tag": "5"},
    {"image": "assets/logo/appLogo.png", "name": "Cycle Length", "tag": "6"},
  ];

  String userFName = "";
  String userLName = "";
  String userHeight = "";
  String userWeight = "";
  String userDob = "";
  String userAge = "";
  int cycleLength = 0;
  String startDate = "";
  String endDate = "";
  String periodLength = "";
  bool isLoading = false;

  Future<void> fetchUserData() async {
    // isLoading = true;
    try {
      setState(() {
        isLoading = true;
      });

      // Get current user ID
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Fetch user document from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();

      // Access user data from the document
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Update UI with user data
        setState(() {
          // Assuming the fields are 'name', 'height', 'weight', 'age'
          // Replace these with your actual field names from Firestore
          userFName = userData['FirstName'] ?? 'First Name';
          userLName = userData['LastName'] ?? 'Last Name';
          userHeight = userData['Height'] ?? '180cm';
          userWeight = userData['Weight'] ?? '70kg';
          userDob = userData['DateOfBirth'] ?? '22';
          cycleLength = userData['AvgCycle'] ?? 28;
          startDate = userData['StartDate'] ?? '22';
          endDate = userData['EndDate'] ?? '22';

          userAge = calculateAge(userDob);
          periodLength = calculateDaysBetween(startDate, endDate);

          print(userFName);
          print(userLName);
          // print(userHeight);
          // print(userWeight);
          print(periodLength);
          print(userDob);
        });
        setState(() {
          isLoading = false;
        });
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  String calculateDaysBetween(String startDateString, String endDateString) {
    // Parse the starting and ending date strings into DateTime objects
    DateTime startDate = DateTime.parse(startDateString);
    DateTime endDate = DateTime.parse(endDateString);

    // Calculate the difference between the ending date and the starting date
    Duration difference = endDate.difference(startDate);

    // Extract the number of days from the difference
    int days = difference.inDays;
    String dayp = '$days days';
    return dayp;
  }

  String calculateAge(String birthDateString) {
    // Parse the birthdate string into a DateTime object
    DateTime birthDate = DateTime.parse(birthDateString);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference between the current date and the birthdate
    Duration difference = currentDate.difference(birthDate);

    // Extract the years from the difference to get the person's age
    int years = (difference.inDays / 365).floor();

    String ageString = '$years years';

    return ageString;
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Call the function to fetch user data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {},
        //     child: Container(
        //       margin: const EdgeInsets.all(8),
        //       height: 40,
        //       width: 40,
        //       alignment: Alignment.center,
        //       decoration: BoxDecoration(
        //           color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        //       // child: Image.asset(
        //       //   "assets/logo/appLogo.png",
        //       //   width: 15,
        //       //   height: 15,
        //       //   fit: BoxFit.contain,
        //       // ),
        //     ),
        //   )
        // ],
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            "assets/images/profile.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$userFName $userLName",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   width: 70,
                        //   height: 25,
                        //   child: RoundButton(
                        //     title: "Edit",
                        //     type: RoundButtonType.bgGradient,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w400,
                        //     onPressed: () {
                        //       // Navigator.push(
                        //       //   context,
                        //       //   MaterialPageRoute(
                        //       //     builder: (context) => const ActivityTrackerView(),
                        //       //   ),
                        //       // );
                        //     },
                        //   ),
                        // )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TitleSubtitleCell(
                            title: "$userHeight cm",
                            subtitle: "Height",
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TitleSubtitleCell(
                            title: "$userWeight kg",
                            subtitle: "Weight",
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TitleSubtitleCell(
                            title: userAge,
                            subtitle: "Age",
                          ),
                        ),
                      ],
                    ),

                    // const SizedBox(
                    //   height: 25,
                    // ),
                    // Container(
                    //   padding:
                    //       const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       borderRadius: BorderRadius.circular(15),
                    //       boxShadow: const [
                    //         BoxShadow(color: Colors.black12, blurRadius: 2)
                    //       ]),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       const Text(
                    //         "Notification",
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 8,
                    //       ),
                    //       SizedBox(
                    //         height: 30,
                    //         child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             children: [
                    //               Image.asset("assets/logo/appLogo.png",
                    //                   height: 15, width: 15, fit: BoxFit.contain),
                    //               const SizedBox(
                    //                 width: 15,
                    //               ),
                    //               const Expanded(
                    //                 child: Text(
                    //                   "Pop-up Notification",
                    //                   style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 12,
                    //                   ),
                    //                 ),
                    //               ),
                    //               // CustomAnimatedToggleSwitch<bool>(
                    //               //   current: positive,
                    //               //   values: const [false, true],
                    //               //   // diff: 0.0,
                    //               //   indicatorSize: const Size.square(30.0),
                    //               //   animationDuration:
                    //               //       const Duration(milliseconds: 200),
                    //               //   animationCurve: Curves.linear,
                    //               //   onChanged: (b) => setState(() => positive = b),
                    //               //   iconBuilder: (context, local, global) {
                    //               //     return const SizedBox();
                    //               //   },
                    //               //   // defaultCursor: SystemMouseCursors.click,
                    //               //   onTap: () => setState(() => positive = !positive),
                    //               //   iconsTappable: false,
                    //               //   wrapperBuilder: (context, global, child) {
                    //               //     return Stack(
                    //               //       alignment: Alignment.center,
                    //               //       children: [
                    //               //         Positioned(
                    //               //             left: 10.0,
                    //               //             right: 10.0,
                    //               //             height: 30.0,
                    //               //             child: DecoratedBox(
                    //               //               decoration: BoxDecoration(
                    //               //                 gradient: LinearGradient(
                    //               //                     colors: AppGradient.grad1),
                    //               //                 borderRadius:
                    //               //                     const BorderRadius.all(
                    //               //                         Radius.circular(50.0)),
                    //               //               ),
                    //               //             )),
                    //               //         child,
                    //               //       ],
                    //               //     );
                    //               //   },
                    //               //   foregroundIndicatorBuilder: (context, global) {
                    //               //     return SizedBox.fromSize(
                    //               //       size: const Size(10, 10),
                    //               //       child: const DecoratedBox(
                    //               //         decoration: BoxDecoration(
                    //               //           color: Colors.white,
                    //               //           borderRadius: BorderRadius.all(
                    //               //               Radius.circular(50.0)),
                    //               //           boxShadow: [
                    //               //             BoxShadow(
                    //               //                 color: Colors.black38,
                    //               //                 spreadRadius: 0.05,
                    //               //                 blurRadius: 1.1,
                    //               //                 offset: Offset(0.0, 0.8))
                    //               //           ],
                    //               //         ),
                    //               //       ),
                    //               //     );
                    //               //   },
                    //               // ),
                    //             ]),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 2)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Profile",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListTile(
                            title: const Text(
                              "Period Length",
                              style: TextStyle(fontSize: 16),
                            ),
                            leading: const Icon(
                              Icons.water_drop_sharp,
                              color: AppColor.red,
                              size: 20,
                            ),
                            trailing: Text(
                              periodLength,
                              style: const TextStyle(fontSize: 14),
                            ),
                            //  style: const TextStyle(fontSize: 14),
                            //  style: const TextStyle(fontSize: 14),
                          ),
                          ListTile(
                            title: const Text(
                              "Cycle Length",
                              style: TextStyle(fontSize: 16),
                            ),
                            leading: const Icon(
                              Icons.replay,
                              color: AppColor.orange,
                              size: 20,
                            ),
                            trailing: Text(
                              '$cycleLength days',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 24,
                          ),
                          const Text(
                            "About Cyclus",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const ListTile(
                            title: Text(
                              "About Developers",
                              style: TextStyle(fontSize: 16),
                            ),
                            leading: Icon(
                              Icons.developer_mode_outlined,
                              color: AppColor.offblack,
                              size: 20,
                            ),
                            // trailing: Text(
                            //   periodLength,
                            //   style: const TextStyle(fontSize: 14),
                            // ),
                            //  style: const TextStyle(fontSize: 14),
                            //  style: const TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Share.share(
                                  'Share Cyclus among your friends');
                            },
                            child: const ListTile(
                              title: Text(
                                "Share",
                                style: TextStyle(fontSize: 16),
                              ),
                              leading: Icon(
                                Icons.share,
                                color: AppColor.orange,
                                size: 20,
                              ),
                              // trailing: Text(
                              //   '$cycleLength days',
                              //   style: const TextStyle(fontSize: 14),
                              // ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 24),

                    RoundButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const SignInScreen();
                            },
                          ),
                          (_) => false,
                        );
                        toast("Logged out Successfully");
                      },
                      title: "Logout",
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
