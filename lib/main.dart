import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';  // Import sizer package
import 'package:device_preview/device_preview.dart';  // Import device_preview

import 'package:project/firebase_options.dart';
import 'package:project/layout/home_screen/home_screen.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(DevicePreview(
    enabled: !kReleaseMode,  // Enable DevicePreview only in debug mode
    builder: (context) => MyApp(), // Wrap your app
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(  // Use Sizer widget to initialize Sizer
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          useInheritedMediaQuery: true,  // Required for DevicePreview to work properly
          locale: DevicePreview.locale(context), // Add the locale from DevicePreview
          builder: DevicePreview.appBuilder, // Add the builder for DevicePreview
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent
                  )
              )
          ),
          home: AnimatedSplashScreen(
            splashIconSize: double.infinity,
            nextScreen: Home_Screen(),
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/image/list.png"), width: 20.w, height: 10.h, fit: BoxFit.cover,),
                SizedBox(height: 5.h,),
                Text("ToDo App", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp
                ),)
              ],
            ),
            splashTransition: SplashTransition.sizeTransition,
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
