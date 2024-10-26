// ignore_for_file: file_names, sized_box_for_whitespace

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Repositroy/get_news_repo.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  // ignore: non_constant_identifier_names
  String date_formate(String x) {
    DateTime dateTime = DateTime.parse(x);
    String formattedDate = DateFormat('EEEE, d MMMM y').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: mediaQuery.size.width,
            height: (landscape)
                ? mediaQuery.size.height * 0.59
                : mediaQuery.size.height * (405 / 812),
            decoration: const BoxDecoration(),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    child: Image.asset(
                      'img/istockphoto-1409329028-612x612.jpg', // Replace with your actual placeholder asset path
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                (shown_news == false)
                    ? Positioned.fill(
                        child: ClipRRect(
                          child: CachedNetworkImage(
                            imageUrl: latest_news[0]
                                    .articles[news_index]
                                    .urlToImage ??
                                "https://media.istockphoto.com/id/1264074047/vector/breaking-news-background.jpg?s=612x612&w=0&k=20&c=C5BryvaM-X1IiQtdyswR3HskyIZCqvNRojrCRLoTN0Q=",
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Container(
                              color: Colors
                                  .transparent, // To ensure the placeholder image is shown underneath
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      )
                    : Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                            imageUrl: news[0].articles[news_index].urlToImage ??
                                "https://media.istockphoto.com/id/1264074047/vector/breaking-news-background.jpg?s=612x612&w=0&k=20&c=C5BryvaM-X1IiQtdyswR3HskyIZCqvNRojrCRLoTN0Q=",
                            fit: BoxFit.fill,
                            placeholder: (context, url) => Container(
                              color: Colors
                                  .transparent, // To ensure the placeholder image is shown underneath
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Container(
                  width: mediaQuery.size.width,
                  height: (landscape)
                      ? mediaQuery.size.height * 0.45
                      : mediaQuery.size.height * (430 / 812),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(
                    top: mediaQuery.size.height * (88 / 812),
                    bottom: mediaQuery.size.height * (16 / 812),
                    left: mediaQuery.size.width * (15 / 375),
                    right: mediaQuery.size.width * (15 / 375),
                  ),
                  child: RichText(
                      text: TextSpan(
                          text: (latest_news[0].articles[news_index].content ==
                                  "If you click 'Accept all', we and our partners, including 240 who are part of the IAB Transparency &amp; Consent Framework, will also store and/or access information on a device (in other words, use … [+678 chars]")
                              ? latest_news[0].articles[news_index].description
                              : latest_news[0]
                                  .articles[news_index]
                                  .content
                                  .replaceAll(RegExp(r'\[\+\d+\s*chars\]'), ''),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                          children: [
                        TextSpan(
                            text: 'Read More',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // ignore: avoid_print
                                print('Read more button clicked!');
                              })
                      ]))),
            ),
          ),
          Positioned(
            left: mediaQuery.size.width * (32 / 375),
            right: mediaQuery.size.width * (32 / 375),
            bottom: (landscape)
                ? mediaQuery.size.height * (275 / 812)
                : mediaQuery.size.height * (360 / 812),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: const Color.fromARGB(0, 255, 255, 255)
                          .withOpacity(0.3)),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      top: 16, bottom: 16, left: 24, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          (shown_news == false)
                              ? date_formate(latest_news[0]
                                  .articles[news_index]
                                  .publishedAt)
                              : date_formate(
                                  news[0].articles[news_index].publishedAt),
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Nunito",
                              fontSize: 12,
                              height: 1.73,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          (shown_news == false)
                              ? latest_news[0].articles[news_index].title
                              : news[0].articles[news_index].title,
                          maxLines: (landscape) ? 2 : 3,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Nunito",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.2,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          (shown_news == false)
                              ? latest_news[0].articles[news_index].author ?? ""
                              : news[0].articles[news_index].author ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontFamily: "Nunito",
                              fontSize: 10,
                              height: 1,
                              fontWeight: FontWeight.w800,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: (landscape)
                ? mediaQuery.size.height * (650 / 812)
                : mediaQuery.size.height * (690 / 812),
            left: mediaQuery.size.width * (304 / 375),
            child: Container(
              width: (landscape)
                  ? mediaQuery.size.height * 0.15
                  : mediaQuery.size.width * 0.15,
              height: (landscape)
                  ? mediaQuery.size.height * 0.15
                  : mediaQuery.size.width * 0.15,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: SvgPicture.asset('img/Component/Group.svg'),
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.08,
                height: MediaQuery.sizeOf(context).width *
                    0.08, // Set the desired height
                child: SvgPicture.asset(
                  'img/Group 26.svg',
                ), // Replace with your image asset
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Navigate back when pressed
              },
            ),
          ),
        ],
      ),
    );
  }
}
