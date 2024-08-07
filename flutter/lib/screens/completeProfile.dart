import 'package:female_health/controller/user_provider.dart';

import 'package:female_health/model/user.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_gradient.dart';
import 'package:female_health/widgets/date_container.dart';
import 'package:female_health/widgets/round_button.dart';
import 'package:female_health/widgets/round_textfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  var dob = '';

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/compProf.png",
                  width: 250,
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Let'\s complete your profile",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      DateContainer(
                        hitText: "Date of Birth",
                        icon: 'assets/logo/date.png',
                        color: AppColor.darkBlue,
                        onDateSelected: (date) {
                          setState(() {
                            dob = date;
                          });
                        },
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              color: Colors.grey,
                              controller: weightController,
                              hitText: "Your Weight",
                              icon: "assets/logo/weight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppGradient.grad3,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "KG",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              color: Colors.grey,
                              controller: heightController,
                              hitText: "Your Height",
                              icon: "assets/logo/height.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppGradient.grad3,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "CM",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.2,
                      ),
                      RoundButton(
                          title: "Next",
                          onPressed: () {
                            final updatedUser = UserModel(
                              uid: userProvider.user!.uid,
                              firstName: userProvider.user!.firstName,
                              lastName: userProvider.user!.lastName,
                              email: userProvider.user!.email,
                              password: userProvider.user!.password,
                              dateOfBirth: dob,
                              weight: weightController.text,
                              height: heightController.text,
                            );
                            userProvider.setUser(updatedUser);

                            Navigator.of(context).pushNamed(RouteName.avgcycle);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
