import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/get_latest_news/get_latest_news_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/functions/style.dart';
import 'package:news_app_ahmed_othman_alhalwagy/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initFunction() async {
      await context.read<GetLatestNewsCubit>().getLatestNews();
      await Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => FirstScreen(),
        ),
      );
    }

    initFunction();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: Container(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        color: const Color.fromRGBO(50, 50, 160, 1),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Container(
                width: mediaQuery.size.width,
                margin: EdgeInsets.only(
                    left: mediaQuery.size.width * (20 / 360),
                    right: mediaQuery.size.width * (20 / 360),
                    bottom: mediaQuery.size.height * (20 / 800)),
                child: Text(
                  "Hello",
                  style: getSplashScreen(context),
                ),
              ),
              Container(
                width: mediaQuery.size.width,
                height: (landscape)
                    ? mediaQuery.size.height * 1 / 2
                    : mediaQuery.size.width * 1 / 2,
                margin: EdgeInsets.only(
                    left: mediaQuery.size.width * (20 / 360),
                    right: mediaQuery.size.width * (20 / 360)),
                child: Image.asset(
                  "img/741867.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "News App",
                        style: getTextWhite(context),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
