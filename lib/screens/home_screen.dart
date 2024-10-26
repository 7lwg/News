// ignore_for_file: invalid_use_of_protected_member, sized_box_for_whitespace, invalid_use_of_visible_for_testing_member, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/get_latest_news/get_latest_news_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/get_news_cubit/get_news_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Cubits/search_cubit/search_cubit.dart';
import 'package:news_app_ahmed_othman_alhalwagy/data/Repositroy/get_news_repo.dart';
import 'package:news_app_ahmed_othman_alhalwagy/functions/style.dart';
import 'package:news_app_ahmed_othman_alhalwagy/screens/seeAll_screen.dart';
import 'package:news_app_ahmed_othman_alhalwagy/screens/newsDetails_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class FirstScreen extends StatelessWidget {
  FirstScreen({super.key});

  bool open = false;

  // ignore: non_constant_identifier_names
  List btn_color = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  // ignore: non_constant_identifier_names
  List<String> btn_text = [
    "Filter",
    "Healthy",
    "Technology",
    "Finance",
    "Arts",
    "Sports"
  ];

  // ignore: non_constant_identifier_names
  List<String> lang_prefix = [
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'he',
    'it',
    'nl',
    'no',
    'pt',
    'ru',
    'sv',
    'ud',
    'zh'
  ];

  // ignore: non_constant_identifier_names
  List<String> lang_name = [
    'Arabic',
    'German',
    'English',
    'Spanish',
    'French',
    'Hebrew',
    'Italian',
    'Dutch',
    'Norwegian',
    'Portuguese',
    'Russian',
    'Swedish',
    'Urdu',
    'Chinese'
  ];

// ignore: non_constant_identifier_names
  int red_lang_color = -1;

  // ignore: non_constant_identifier_names
  int red_sort_color = -1;

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final landscape = mediaQuery.orientation == Orientation.landscape;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Column(
                  children: [
                    (MediaQuery.of(context).padding.top > 0)
                        ? SizedBox(
                            height: MediaQuery.of(context).padding.top * 1.5,
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      width: mediaQuery.size.width * 0.95,
                      height: (landscape)
                          ? mediaQuery.size.width * 0.05
                          : mediaQuery.size.height * 0.05,
                      child: Center(
                        child: Focus(
                          onFocusChange: (value) {
                            if (value == true) {
                              search = true;
                              context.read<SearchCubit>();
                            }
                          },
                          child: TextFormField(
                            controller: _controller,
                            onChanged: (text) {
                              if (!btn_color.contains(Colors.red)) {
                                topic = text;
                                context.read<GetNewsCubit>().getNews(topic);
                              } else {
                                search_text = text;
                                context
                                    .read<GetNewsCubit>()
                                    .getNews(search_text);
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    context.read<SearchCubit>().search_icon();
                                    if (search == false) {
                                      search_text = '';
                                      if (btn_color.contains(Colors.red) ==
                                          false) {
                                        topic = '';

                                        context
                                            .read<GetNewsCubit>()
                                            .emit(GetNewsInitial());
                                      } else {
                                        context
                                            .read<GetNewsCubit>()
                                            .getNews(topic);
                                      }
                                      search_text = '';
                                      _controller.clear();
                                      FocusScope.of(context).unfocus();
                                      btn_color[0] = Colors.white;
                                      lang = 'en';
                                      sort = '';
                                      red_lang_color = -1;
                                      red_sort_color = -1;
                                    }
                                  },
                                  child: (search == false)
                                      ? const Icon(Icons.search)
                                      : const Icon(Icons.close),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                hintText: 'Search',
                                hintStyle: getTextGrey(context)),
                          ),
                        ),
                      ),
                    ),
                    (search == false)
                        ? Container(
                            width: mediaQuery.size.width * 0.95,
                            height: (landscape)
                                ? mediaQuery.size.width * 0.08
                                : mediaQuery.size.height * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Latest News',
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            // ignore: prefer_const_constructors
                                            SeeAllScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('See All',
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                color: Colors.blue,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w900)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox(),
                    (search == false)
                        ? Container(
                            height: (landscape)
                                ? mediaQuery.size.width * 0.3
                                : mediaQuery.size.height * 0.3,
                            width: mediaQuery.size.width,
                            padding: const EdgeInsets.only(left: 10),
                            child: BlocBuilder<GetLatestNewsCubit,
                                GetLatestNewsState>(
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
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          news_index = index;
                                          shown_news = false;
                                          Navigator.push(
                                            // ignore: use_build_context_synchronously
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  const ThirdScreen(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Stack(
                                            children: [
                                              TweenAnimationBuilder<double>(
                                                duration:
                                                    const Duration(seconds: 2),
                                                tween:
                                                    Tween(begin: -300, end: 0),
                                                child: Container(
                                                  width: (landscape)
                                                      ? MediaQuery.of(context)
                                                          .size
                                                          .height
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          (321 / 375),
                                                  height: (landscape)
                                                      ? MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.3
                                                      : MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.3,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Positioned.fill(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Image.asset(
                                                            'img/istockphoto-1409329028-612x612.jpg', // Replace with your actual placeholder asset path
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned.fill(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: state
                                                                    .response
                                                                    .articles[
                                                                        index]
                                                                    .urlToImage ??
                                                                "https://media.istockphoto.com/id/1264074047/vector/breaking-news-background.jpg?s=612x612&w=0&k=20&c=C5BryvaM-X1IiQtdyswR3HskyIZCqvNRojrCRLoTN0Q=",
                                                            fit: BoxFit.fill,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              color: Colors
                                                                  .transparent, // To ensure the placeholder image is shown underneath
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                builder:
                                                    (context, value, child) {
                                                  return Transform.translate(
                                                    offset: Offset(0, value),
                                                    child: child,
                                                  );
                                                },
                                              ),
                                              Container(
                                                width: (landscape)
                                                    ? MediaQuery.of(context)
                                                        .size
                                                        .height
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        (305 / 375),
                                                height: (landscape)
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.22
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.22,
                                                margin: EdgeInsets.only(
                                                  top: (landscape)
                                                      ? mediaQuery.size.width *
                                                          0.08
                                                      : mediaQuery.size.height *
                                                          0.08,
                                                ),
                                                child: Column(children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: (landscape)
                                                        ? MediaQuery.of(context)
                                                            .size
                                                            .height
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            (289 / 375),
                                                    height: (landscape)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.017
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.017,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent
                                                          .withOpacity(
                                                              0.5), // 50% opacity
                                                    ),
                                                    child: Text(
                                                      state
                                                              .response
                                                              .articles[index]
                                                              .author ??
                                                          "",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: Colors.white,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: (landscape)
                                                        ? MediaQuery.of(context)
                                                            .size
                                                            .height
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            (289 / 375),
                                                    height: (landscape)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.0777
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.077,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent
                                                          .withOpacity(
                                                              0.5), // 50% opacity
                                                    ),
                                                    child: Text(
                                                      state
                                                          .response
                                                          .articles[index]
                                                          .title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 1.3),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: (landscape)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.0378
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.0378,
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 16),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width: (landscape)
                                                        ? MediaQuery.of(context)
                                                            .size
                                                            .height
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            (289 / 375),
                                                    height: (landscape)
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.064
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.064,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent
                                                          .withOpacity(
                                                              0.5), // 50% opacity
                                                    ),
                                                    child: Text(
                                                      state
                                                              .response
                                                              .articles[index]
                                                              .description ??
                                                          state
                                                              .response
                                                              .articles[index]
                                                              .content,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Center(
                                    child: Text('Something went wrong'),
                                  );
                                }
                              },
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 30,
                    ),
                    TweenAnimationBuilder<double>(
                      duration: const Duration(seconds: 2),
                      tween: Tween(begin: -200, end: 0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width * (370 / 375),
                        height: (landscape)
                            ? MediaQuery.of(context).size.width * (32 / 812)
                            : MediaQuery.of(context).size.height * (32 / 812),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (search == true || topic != '') ? 6 : 5,
                          itemBuilder: (context, index) {
                            return BlocBuilder<GetNewsCubit, GetNewsState>(
                              builder: (context, state) {
                                return Container(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 1),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if ((index == 0 && search == true) ||
                                          (index == 0 && topic != '')) {
                                        if (topic != '') {
                                          if (index != 0) {
                                            btn_color[index] = Colors.red;
                                          }
                                          if (sort == 'relevancy') {
                                            red_sort_color = 0;
                                          } else if (sort == 'publishedAt') {
                                            red_sort_color = 1;
                                          } else if (sort == 'popularity') {
                                            red_sort_color = 2;
                                          } else {
                                            red_sort_color = -1;
                                          }
                                          if (lang != 'en') {
                                            red_lang_color =
                                                lang_prefix.indexWhere(
                                              (element) => element == lang,
                                            );
                                          }

                                          context
                                              .read<SearchCubit>()
                                              .emit(SearchInitial());

                                          showModalBottomSheet(
                                              context: context,
                                              builder:
                                                  (context) =>
                                                      SingleChildScrollView(
                                                        child: Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            padding:
                                                                EdgeInsets.only(
                                                              top: (landscape)
                                                                  ? mediaQuery
                                                                          .size
                                                                          .width *
                                                                      0.02
                                                                  : mediaQuery
                                                                          .size
                                                                          .height *
                                                                      0.02,
                                                              left: (landscape)
                                                                  ? mediaQuery
                                                                          .size
                                                                          .width *
                                                                      0.02
                                                                  : mediaQuery
                                                                          .size
                                                                          .height *
                                                                      0.02,
                                                              right: (landscape)
                                                                  ? mediaQuery
                                                                          .size
                                                                          .width *
                                                                      0.02
                                                                  : mediaQuery
                                                                          .size
                                                                          .height *
                                                                      0.02,
                                                            ),
                                                            decoration:
                                                                const BoxDecoration(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20)),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: BlocBuilder<
                                                                SearchCubit,
                                                                SearchState>(
                                                              builder: (context,
                                                                  state) {
                                                                return Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        const Text(
                                                                          'Filter',
                                                                          style: TextStyle(
                                                                              fontSize: 22,
                                                                              fontFamily: 'Nunito',
                                                                              fontWeight: FontWeight.w700),
                                                                        ),
                                                                        const Spacer(),
                                                                        ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              sort = '';
                                                                              lang = 'en';
                                                                              red_lang_color = -1;
                                                                              red_sort_color = -1;
                                                                              btn_color[0] = Colors.white;
                                                                              context.read<SearchCubit>().emit(SearchInitial());
                                                                            },
                                                                            child:
                                                                                const Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.delete,
                                                                                  color: Colors.red,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                Text(
                                                                                  'Reset',
                                                                                  style: TextStyle(fontFamily: 'Nunito', fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black),
                                                                                ),
                                                                              ],
                                                                            ))
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          height: (landscape)
                                                                              ? MediaQuery.sizeOf(context).width * 0.02
                                                                              : MediaQuery.sizeOf(context).height * 0.02,
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 16),
                                                                          child:
                                                                              const Text(
                                                                            'Sort By',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Nunito',
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.black),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: (red_sort_color == 0) ? Colors.red : Colors.white),
                                                                                onPressed: () {
                                                                                  red_sort_color = 0;
                                                                                  context.read<SearchCubit>().emit(SearchInitial());
                                                                                },
                                                                                child: Text(
                                                                                  'Recommended',
                                                                                  style: TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w600, color: (red_sort_color == 0) ? Colors.white : Colors.black),
                                                                                )),
                                                                            const SizedBox(
                                                                              width: 6,
                                                                            ),
                                                                            ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: (red_sort_color == 1) ? Colors.red : Colors.white),
                                                                                onPressed: () {
                                                                                  red_sort_color = 1;
                                                                                  context.read<SearchCubit>().emit(SearchInitial());
                                                                                },
                                                                                child: Text(
                                                                                  'Latest',
                                                                                  style: TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w600, color: (red_sort_color == 1) ? Colors.white : Colors.black),
                                                                                )),
                                                                            const SizedBox(
                                                                              width: 6,
                                                                            ),
                                                                            ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(backgroundColor: (red_sort_color == 2) ? Colors.red : Colors.white),
                                                                                onPressed: () {
                                                                                  red_sort_color = 2;
                                                                                  context.read<SearchCubit>().emit(SearchInitial());
                                                                                },
                                                                                child: Text(
                                                                                  'Most Viewed',
                                                                                  style: TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w600, color: (red_sort_color == 2) ? Colors.white : Colors.black),
                                                                                )),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: (landscape)
                                                                              ? MediaQuery.sizeOf(context).width * 0.02
                                                                              : MediaQuery.sizeOf(context).height * 0.02,
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              left: 16),
                                                                          child:
                                                                              const Text(
                                                                            'Language',
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontFamily: 'Nunito',
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Colors.black),
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              5),
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width,
                                                                          height: (landscape)
                                                                              ? MediaQuery.sizeOf(context).width * 0.06
                                                                              : MediaQuery.sizeOf(context).height * 0.06,
                                                                          child: ListView.builder(
                                                                              scrollDirection: Axis.horizontal,
                                                                              itemCount: 14,
                                                                              itemBuilder: (context, index) {
                                                                                return Container(
                                                                                  // margin: const EdgeInsets.only(right: 8),
                                                                                  padding: const EdgeInsets.only(right: 8, bottom: 1),
                                                                                  child: ElevatedButton(
                                                                                      style: ElevatedButton.styleFrom(backgroundColor: (index == red_lang_color) ? Colors.red : Colors.white),
                                                                                      onPressed: () {
                                                                                        red_lang_color = index;

                                                                                        context.read<SearchCubit>().emit(SearchInitial());
                                                                                      },
                                                                                      child: Text(
                                                                                        lang_name[index],
                                                                                        style: TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.w600, color: (red_lang_color == index) ? Colors.white : Colors.black),
                                                                                      )),
                                                                                );
                                                                              }),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              8,
                                                                        ),
                                                                        Container(
                                                                          color:
                                                                              Colors.white,
                                                                          width: (landscape)
                                                                              ? mediaQuery.size.height * (345 / mediaQuery.size.height)
                                                                              : mediaQuery.size.width * (345 / mediaQuery.size.width),
                                                                          height: (landscape)
                                                                              ? mediaQuery.size.width * (48 / mediaQuery.size.width)
                                                                              : mediaQuery.size.height * (48 / mediaQuery.size.height),
                                                                          child:
                                                                              ElevatedButton(
                                                                            onPressed:
                                                                                () {
                                                                              if (red_sort_color == 0) {
                                                                                sort = 'relevancy';
                                                                              } else if (red_sort_color == 1) {
                                                                                sort = 'publishedAt';
                                                                              } else if (red_sort_color == 2) {
                                                                                sort = 'popularity';
                                                                              }
                                                                              if (red_lang_color != -1) {
                                                                                lang = lang_prefix[red_lang_color];
                                                                              }
                                                                              if (lang != 'en' || sort != '') {
                                                                                btn_color[0] = Colors.red;
                                                                              }

                                                                              context.read<SearchCubit>().emit(SearchInitial());
                                                                              context.read<GetNewsCubit>().getNews(topic);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            // ignore: sort_child_properties_last
                                                                            child:
                                                                                const Text(
                                                                              'Save',
                                                                              style: TextStyle(fontFamily: 'Nunito', fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                                                                            ),
                                                                            style:
                                                                                ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              mediaQuery.size.height * 0.03,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            )),
                                                      ));
                                        } else {
                                          _showToast(
                                              'You should select a topic or search about it to do the filter');
                                        }
                                      } else {
                                        search_text = '';
                                        _controller.clear();
                                        for (int j = 1; j < 6; j++) {
                                          btn_color[j] = Colors.white;
                                        }
                                        if (search == true || topic != '') {
                                          btn_color[index] = Colors.red;
                                          if (index == 1) {
                                            topic = "Healthy";
                                          } else if (index == 2) {
                                            topic = "Technology";
                                          } else if (index == 3) {
                                            topic = " Finance";
                                          } else if (index == 4) {
                                            topic = "Arts";
                                          } else if (index == 5) {
                                            topic = "Sports";
                                          }
                                        } else {
                                          btn_color[index + 1] = Colors.red;
                                          if (index == 0) {
                                            topic = "Healthy";
                                          } else if (index == 1) {
                                            topic = "Technology";
                                          } else if (index == 2) {
                                            topic = " Finance";
                                          } else if (index == 3) {
                                            topic = "Arts";
                                          } else if (index == 4) {
                                            topic = "Sports";
                                          }
                                        }

                                        context
                                            .read<GetNewsCubit>()
                                            .getNews(topic);
                                      }
                                      context
                                          .read<SearchCubit>()
                                          .emit(SearchInitial());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          (search == true || topic != '')
                                              ? btn_color[index]
                                              : btn_color[index + 1],
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    child: (search == true || topic != '')
                                        ? (index == 0)
                                            ? Row(
                                                children: [
                                                  Icon(
                                                    Icons.filter_alt,
                                                    color: (btn_color[index] ==
                                                            Colors.red)
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  Text('Filter',
                                                      style: TextStyle(
                                                          color: (btn_color[
                                                                      index] ==
                                                                  Colors.red)
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontSize: 12,
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w600))
                                                ],
                                              )
                                            : Text(
                                                btn_text[index],
                                                style: TextStyle(
                                                    color: (btn_color[index] ==
                                                            Colors.red)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 12,
                                                    fontFamily: 'Nunito',
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                        : Text(
                                            btn_text[index + 1].toString(),
                                            style: TextStyle(
                                                color: (btn_color[index + 1] ==
                                                        Colors.red)
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value, 0),
                          child: child,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Container(
                  height: (landscape)
                      ? (search == true)
                          ? mediaQuery.size.height * 0.75
                          : mediaQuery.size.height * 0.75
                      : (search == true)
                          ? mediaQuery.size.height * 0.82
                          : mediaQuery.size.height * 0.44,
                  child: BlocBuilder<GetNewsCubit, GetNewsState>(
                    builder: (context, state) {
                      if (state is GetNewsInitial) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: mediaQuery.size.height * 0.03),
                              child:
                                  const Text("Choose the catigory you want")),
                        );
                      } else if (state is GetNewsLodding) {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: mediaQuery.size.height * 0.03),
                              child: const CircularProgressIndicator()),
                        );
                      } else if (state is GetNewsSuccess) {
                        return Column(
                          children: [
                            SizedBox(
                              height: mediaQuery.size.height * 0.03,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.response.articles.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      news_index = index;
                                      shown_news = true;
                                      Navigator.push(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const ThirdScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: (index == 0)
                                          ? const EdgeInsets.only(
                                              bottom: 10,
                                              top: 0,
                                              left: 5,
                                              right: 5)
                                          : const EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                              left: 5,
                                              right: 5),
                                      height: (landscape)
                                          ? mediaQuery.size.height * 0.4
                                          : mediaQuery.size.height * 0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                'img/istockphoto-1409329028-612x612.jpg', // Replace with your actual placeholder asset path
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: state
                                                        .response
                                                        .articles[index]
                                                        .urlToImage ??
                                                    "https://media.istockphoto.com/id/1264074047/vector/breaking-news-background.jpg?s=612x612&w=0&k=20&c=C5BryvaM-X1IiQtdyswR3HskyIZCqvNRojrCRLoTN0Q=",
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  color: Colors
                                                      .transparent, // To ensure the placeholder image is shown underneath
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent
                                                      .withOpacity(
                                                          0.5), // 50% opacity
                                                ),
                                                child: Text(
                                                  state.response.articles[index]
                                                      .title,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const Spacer(),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: mediaQuery
                                                                .size.width *
                                                            0.45, // Specify the maximum width
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .transparent
                                                              .withOpacity(
                                                                  0.5), // 50% opacity
                                                        ),
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          state
                                                                  .response
                                                                  .articles[
                                                                      index]
                                                                  .author ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .transparent
                                                            .withOpacity(
                                                                0.5), // 50% opacity
                                                      ),
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        date_formate(state
                                                            .response
                                                            .articles[index]
                                                            .publishedAt),
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                    },
                  ),
                );
              },
            )
            // CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
String date_formate(String x) {
  DateTime dateTime = DateTime.parse(x);
  String formattedDate = DateFormat('EEEE, d MMMM y').format(dateTime);
  return formattedDate;
}
