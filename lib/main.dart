import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/get_latest_news/get_latest_news_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/get_news_cubit/get_news_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/search_cubit/search_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:news_app_ahmed_othman_alhalwagy/screens/splash_screen.dart';
// import 'package:news_app_ahmed_othman_alhalwagy/screens/test.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // ignore: unused_local_variable
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification != null) {
      // print('Message also contained a notification: ${message.notification}');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNewsCubit>(
          create: (BuildContext context) => GetNewsCubit(),
        ),
        BlocProvider<GetLatestNewsCubit>(
          create: (BuildContext context) => GetLatestNewsCubit(),
        ),
        BlocProvider<SearchCubit>(
          create: (BuildContext context) => SearchCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        builder: (context, Widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, Widget!),
            breakpoints: [
              const ResponsiveBreakpoint.resize(350, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(600, name: TABLET),
              const ResponsiveBreakpoint.resize(800, name: DESKTOP),
              const ResponsiveBreakpoint.resize(1200, name: 'XL'),
            ]),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        // home: Test()
        // home: FirstScreen(),
        // home: SecondScreen(),
        // home: ThirdScreen(),
        // home: FourthScreen(),
      ),
    );
  }
}
