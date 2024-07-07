import 'package:female_health/controller/user_provider.dart';
import 'package:female_health/model/user.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/utils/app_gradient.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class AvgCycle extends StatefulWidget {
  const AvgCycle({super.key});

  @override
  State<AvgCycle> createState() => _AvgCycleState();
}

class _AvgCycleState extends State<AvgCycle> {
  int _currentValue = 28;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/track.png",
              width: 250,
            ),
            SizedBox(
              height: media.width * 0.15,
            ),
            const Text(
              textAlign: TextAlign.center,
              "How long is your average cycle?",
              style: TextStyle(
                  color: AppColor.darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: media.width * 0.01,
            ),
            const Text(
              "Tip : Cycles usually last 24-38 days",
              style: TextStyle(
                color: AppColor.darkBlue,
                fontSize: 14,
              ),
            ),
            SizedBox(
              height: media.width * 0.15,
            ),
            NumberPicker(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.yellow),
                  borderRadius: BorderRadius.circular(30)),
              value: _currentValue,
              axis: Axis.horizontal,
              selectedTextStyle:
                  const TextStyle(color: AppColor.orange, fontSize: 30),
              minValue: 1,
              maxValue: 40,
              onChanged: (value) => setState(() => _currentValue = value),
            ),
            SizedBox(
              height: media.width * 0.1,
            ),
            Text('Your average cycle is: $_currentValue Days'),
            SizedBox(
              height: media.width * 0.1,
            ),
            Row(
              children: [
                OutlinedButton(
                    onPressed: () {
                      int avgCycle = 28;
                      final updatedUser = UserModel(
                        uid: userProvider.user!.uid,
                        firstName: userProvider.user!.firstName,
                        lastName: userProvider.user!.lastName,
                        email: userProvider.user!.email,
                        password: userProvider.user!.password,
                        dateOfBirth: userProvider.user!.dateOfBirth,
                        weight: userProvider.user!.weight,
                        height: userProvider.user!.height,
                        avgCycle: avgCycle,
                      );
                      userProvider.setUser(updatedUser);
                      Navigator.of(context).pushNamed(RouteName.periodDates);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColor.orange,
                      minimumSize: Size(media.width / 2.2, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                    child:
                        const Text('Not Sure', style: TextStyle(fontSize: 18))),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(colors: AppGradient.grad1)),
                  child: ElevatedButton(
                      onPressed: () {
                        int avgCycle = _currentValue;
                        final updatedUser = UserModel(
                          uid: userProvider.user!.uid,
                          firstName: userProvider.user!.firstName,
                          lastName: userProvider.user!.lastName,
                          email: userProvider.user!.email,
                          password: userProvider.user!.password,
                          dateOfBirth: userProvider.user!.dateOfBirth,
                          weight: userProvider.user!.weight,
                          height: userProvider.user!.height,
                          avgCycle: avgCycle,
                        );
                        userProvider.setUser(updatedUser);

                        Navigator.of(context).pushNamed(RouteName.periodDates);
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        minimumSize: Size(media.width / 2.2, 50),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(color: AppColor.white, fontSize: 18),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
