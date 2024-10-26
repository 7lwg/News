// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/get_latest_news/get_latest_news_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Repositroy/get_news_repo.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const Text(
          'Hot Updates',
          style: TextStyle(
              color: Colors.red, fontSize: 17, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 16),
        child: BlocBuilder<GetLatestNewsCubit, GetLatestNewsState>(
          builder: (context, state) {
            if (state is GetLatestNewsInitial) {
              return const Center(
                child: Text("Choose the catigory you want"),
              );
            } else if (state is GetLatestNewsLoading) {
              return Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is GetLatestNewsSuccess) {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: latest_news[0].articles.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: (landscape)
                              ? MediaQuery.of(context).size.height * (300 / 812)
                              : MediaQuery.of(context).size.height *
                                  (128 / 812),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    'img/istockphoto-1409329028-612x612.jpg', // Replace with your actual placeholder asset path
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: latest_news[0]
                                            .articles[index]
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
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          date_formate(
                              latest_news[0].articles[index].publishedAt),
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              height: 1.73),
                        ),
                        Text(
                          latest_news[0].articles[index].title,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.48),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // ignore: sized_box_for_whitespace
                        Container(
                            width:
                                MediaQuery.of(context).size.width * (343 / 375),
                            child: RichText(
                                text: TextSpan(
                                    text: latest_news[0]
                                        .articles[index]
                                        .content
                                        .replaceAll(
                                            RegExp(r'\[\+\d+\s*chars\]'), ''),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: "Nunito",
                                        fontWeight: FontWeight.w400,
                                        height: 1.5),
                                    children: [
                                  TextSpan(
                                      text: 'Read More',
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // ignore: avoid_print
                                          print('Read more button clicked!');
                                        })
                                ]))),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          'Published by Berkeley Lovelace Jr.',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              height: 1.73),
                        ),
                        SizedBox(
                          height: (landscape)
                              ? MediaQuery.of(context).size.width * (24 / 812)
                              : MediaQuery.of(context).size.height * (24 / 812),
                        ),
                      ],
                    );
                  });
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
      ),
    );
  }
}
