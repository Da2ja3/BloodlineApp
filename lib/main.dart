// this is the main dart where the whole application is built from

import 'package:bloodline/screens/splashscreen.dart';
import 'package:bloodline/utils/app_colors.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// this is a package used to change the orientation of an app to fit different
// screensize
void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Bloodline',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: MainColors.primary),
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
    );
  }
}
