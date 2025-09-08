// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
          ),
          width: 350,
          height: 50,
          child: const Row(
            children: [
              Text(
                'COVID New Variant',
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Icon(
                Icons.close,
              ),
            ],
          ),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 16,
        ),
        Container(
          padding: const EdgeInsets.only(left: 16),
          width: MediaQuery.of(context).size.width * (370 / 375),
          height: MediaQuery.of(context).size.height * (32 / 812),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                          height:
                              MediaQuery.of(context).size.height * (315 / 812),
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                              top: 32, bottom: 32, left: 16, right: 16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Column(
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
                                      onPressed: () {},
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'img/garbage.svg',
                                            width: 10,
                                            height: 12,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            'Reset',
                                            style: TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.only(left: 16),
                                    child: const Text(
                                      'Sort By',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {},
                                          child: const Text(
                                            'Recommended',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {},
                                          child: const Text(
                                            'Latest',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {},
                                          child: const Text(
                                            'Most Viewed',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {},
                                          child: const Text(
                                            'Channel',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white),
                                          onPressed: () {},
                                          child: const Text(
                                            'Following',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: 345,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      // ignore: sort_child_properties_last
                                      child: const Text(
                                        'Save',
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          // Center(
                          //     child: ElevatedButton(
                          //         onPressed: () => Navigator.pop(context),
                          //         child: Text('Close'))),
                          ));
                },
                style: ElevatedButton.styleFrom(
                  // shadowColor: Colors.black,
                  // elevation: 10,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  // minimumSize: Size(200, 40),
                  // minimumSize: Size(350, 50),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Healthy',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Technology',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // shadowColor: Colors.black,
                  // elevation: 10,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  // minimumSize: Size(200, 40),
                  // minimumSize: Size(350, 50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Finance',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // shadowColor: Colors.black,
                  // elevation: 10,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  // minimumSize: Size(200, 40),
                  // minimumSize: Size(350, 50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Arts',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // shadowColor: Colors.black,
                  // elevation: 10,
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  // minimumSize: Size(200, 40),
                  // minimumSize: Size(350, 50),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: const Text(
                  'Sports',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        // Text('About 11,130,000 results for COVID New Variant.'),
        const Text.rich(
          TextSpan(
            text: 'About 11,130,000 results for ',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito'),
            children: [
              TextSpan(
                  text: 'COVID New Variant.',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          // ignore: sized_box_for_whitespace
          child: Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width * (345 / 375),
            // height: MediaQuery.of(context).size.height * (200 / 812),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Image.asset('img/Frame 33 (1).png'),
                const SizedBox(
                  height: 8,
                ),
                Image.asset('img/Frame 34.png'),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(
                  'img/Frame 33 (1).png',
                ),
                const SizedBox(
                  height: 8,
                ),
                Image.asset('img/Frame 33 (1).png'),
                const SizedBox(
                  height: 8,
                ),
                Image.asset('img/Frame 34.png'),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(
                  'img/Frame 33 (1).png',
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
