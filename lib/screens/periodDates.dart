import 'package:female_health/controller/user_provider.dart';
import 'package:female_health/firebase_const.dart';
import 'package:female_health/model/user.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:female_health/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:provider/provider.dart';

class PeriodDates extends StatefulWidget {
  const PeriodDates({super.key});

  @override
  State<PeriodDates> createState() => PeriodDatesState();
}

class PeriodDatesState extends State<PeriodDates> {
  List<DateTime?> _dates = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 9))
  ];

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
            // SizedBox(
            //   height: media.width * 0.15,
            // ),
            const Text(
              textAlign: TextAlign.center,
              "Select Start & End Date of your last period cycle",
              style: TextStyle(
                  color: AppColor.darkBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: media.width * 0.15,
            ),
            _buildDefaultRangeDatePickerWithValue(),
            SizedBox(
              height: media.width * 0.05,
            ),
            RoundButton(
                title: "Proceed",
                onPressed: () async {
                  final updatedUser = UserModel(
                    uid: userProvider.user!.uid,
                    firstName: userProvider.user!.firstName,
                    lastName: userProvider.user!.lastName,
                    email: userProvider.user!.email,
                    password: userProvider.user!.password,
                    dateOfBirth: userProvider.user!.dateOfBirth,
                    weight: userProvider.user!.weight,
                    height: userProvider.user!.height,
                    avgCycle: userProvider.user!.avgCycle,
                    startDate: startDate.trim(),
                    endDate: endDate.trim(),
                  );
                  userProvider.setUser(updatedUser);

                  await storeUserData(updatedUser);

                  Navigator.of(context).pushNamed(RouteName.navBar);
                }),
          ],
        ),
      ),
    );
  }

  Future<void> storeUserData(UserModel userModel) async {
    try {
      await firestore
          .collection('Users')
          .doc(userModel.uid)
          .set(userModel.toJson());
      print('User data stored successfully in Firestore');
    } catch (error) {
      print('Error storing user data in Firestore: $error');
    }
  }

  Widget _buildDefaultRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: AppColor.orange,
      weekdayLabelTextStyle: const TextStyle(
        color: AppColor.darkBlue,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: AppColor.darkBlue,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          value: _dates,
          onValueChanged: (dates) => setState(() => _dates = dates),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Start Date:',
              style: TextStyle(color: AppColor.darkBlue),
            ),
            const SizedBox(width: 10),
            Text(
                _getStartText(
                  config.calendarType,
                  _dates,
                ),
                style: const TextStyle(color: AppColor.red)),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('End Date:', style: TextStyle(color: AppColor.darkBlue)),
            const SizedBox(width: 10),
            Text(
                _getEndText(
                  config.calendarType,
                  _dates,
                ),
                style: const TextStyle(color: AppColor.red)),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  String startDate = '';
  String endDate = '';

  String _getStartText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : '';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : '';
        valueText = '$startDate to $endDate';
      } else {
        return '';
      }
    }

    return startDate;
  }

  String _getEndText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    // String endDate = '';
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : '';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : '';
        valueText = '$startDate to $endDate';
      } else {
        return '';
      }
    }

    return endDate;
  }
}
