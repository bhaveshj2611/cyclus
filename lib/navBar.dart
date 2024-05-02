import 'package:female_health/screens/chat.dart';
import 'package:female_health/screens/exercise.dart';
import 'package:female_health/screens/home_screen.dart';
import 'package:female_health/screens/profile.dart';
// import 'package:female_health/screens/tracker.dart';
import 'package:female_health/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;

    controller = PersistentTabController(initialIndex: 0);

    List<Widget> buildScreens() {
      return [
        const Home(),
        ExerciseScreen(),

        // const Tracker(),

        const Profile(),
        const ChatScreen(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveColorPrimary: AppColor.offwhite,
          activeColorPrimary: AppColor.yellow,
          title: ("Home"),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.sports_gymnastics_outlined),
          title: ("Exercise"),
          activeColorSecondary: AppColor.white,
          inactiveColorSecondary: AppColor.orange,
          inactiveColorPrimary: AppColor.offwhite,
          activeColorPrimary: AppColor.yellow,
        ),
        // PersistentBottomNavBarItem(
        //   icon: const Icon(Icons.add),
        //   iconSize: 35,
        //   title: ("Tracker"),
        //   inactiveColorPrimary: AppColor.offwhite,
        //   activeColorPrimary: AppColor.yellow,
        // ),

        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          inactiveColorPrimary: AppColor.offwhite,
          activeColorPrimary: AppColor.yellow,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.chat_bubble),
          inactiveColorPrimary: AppColor.offwhite,
          activeColorPrimary: AppColor.yellow,
          title: ("Chat"),
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColor.red,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: AppColor.red,
      ),
      navBarHeight: 70,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 500),
      ),
      navBarStyle: NavBarStyle.style5,
    );
  }
}
