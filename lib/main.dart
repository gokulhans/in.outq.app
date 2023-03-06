import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:outq/Backend/api/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outq/firebase_options.dart';
import 'package:outq/screens/shared/splash/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  messaging.getToken().then((token) {
    print('Device token 2 : $token');
  });

  messaging.onTokenRefresh.listen((token) {
    print('Device token refreshed: $token');
    // Update the device token in your server
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white, // navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light),
  );
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String? ownerid = prefs.getString("ownerid");
  // String? userid = prefs.getString("userid");
  // // print(ownerid);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
            ),
            headline2: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            headline3: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            headline4: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            headline5: GoogleFonts.poppins(
              color: Colors.blue,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            headline6: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            subtitle1: GoogleFonts.poppins(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            subtitle2: GoogleFonts.poppins(
              color: Colors.black54,
              fontSize: 12,
            ),
          )),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
