import 'package:female_health/controller/loading_provider.dart';
import 'package:female_health/controller/user_provider.dart';

import 'package:female_health/firebase_options.dart';
import 'package:female_health/routes/custom_route.dart';
import 'package:female_health/routes/route_name.dart';
import 'package:female_health/screens/splash_screen.dart';
import 'package:female_health/utils/app_color.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoadingProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splash,
      onGenerateRoute: CustomRoute.allRoutes,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
