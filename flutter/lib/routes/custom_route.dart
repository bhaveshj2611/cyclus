import 'package:female_health/navBar.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/screens/avgCycle.dart';
import 'package:female_health/screens/completeProfile.dart';
import 'package:female_health/screens/exercise.dart';
import 'package:female_health/screens/home_screen.dart';
import 'package:female_health/screens/onboarding/onboarding_view.dart';
import 'package:female_health/screens/periodDates.dart';
import 'package:female_health/screens/profile.dart';
import 'package:female_health/screens/sign_in.dart';
import 'package:female_health/screens/sign_up.dart';
import 'package:female_health/screens/splash_screen.dart';
import 'package:female_health/screens/tracker.dart';

import 'package:flutter/material.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteName.splash:
          return const SplashScreen();
        case RouteName.onboarding:
          return const OnboardingView();
        case RouteName.signUp:
          return const SignUpScreen();
        case RouteName.signIn:
          return const SignInScreen();
        case RouteName.home:
          return const Home();
        case RouteName.tracker:
          return const Tracker();
        case RouteName.exercises:
          return ExerciseScreen();
        case RouteName.profile:
          return const Profile();
        case RouteName.completeprofile:
          return const CompleteProfileView();
        case RouteName.avgcycle:
          return const AvgCycle();
        case RouteName.periodDates:
          return const PeriodDates();
        case RouteName.navBar:
          return const NavBar();

        default:
          return const Scaffold(body: Center(child: Text('Route not found')));
      }
    });
  }
}
