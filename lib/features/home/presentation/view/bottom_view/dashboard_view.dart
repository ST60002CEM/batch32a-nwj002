import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List imageList = [
    {"id": 1, "image_path": 'assets/images/b1.jpg'},
    {"id": 2, "image_path": 'assets/images/b2.jpg'},
    {"id": 3, "image_path": 'assets/images/b3.jpg'}
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                child: CarouselSlider(
                  items: imageList
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                            width: 370,
                          ),
                        ),
                      )
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 3,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 20,
              //   left: 0,
              //   right: 0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: imageList.asMap().entries.map((entry) {
              //       return GestureDetector(
              //         onTap: () => carouselController.animateToPage(entry.key),
              //         child: Container(
              //           width: currentIndex == entry.key ? 17 : 7,
              //           height: 7.0,
              //           margin: const EdgeInsets.symmetric(
              //             horizontal: 3.0,
              //           ),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               color: currentIndex == entry.key
              //                   ? Colors.red
              //                   : Colors.teal),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
