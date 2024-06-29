import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/core/common/my_product_card.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/products_viewmodel.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final ScrollController _scrollController = ScrollController();

  List imageList = [
    {"id": 1, "image_path": 'assets/images/b1.jpg'},
    {"id": 2, "image_path": 'assets/images/b2.jpg'},
    {"id": 3, "image_path": 'assets/images/b3.jpg'}
  ];

  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          ref.read(productViewModelProvider.notifier).getProducts();
        }
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _scrollController,
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
                                width: screenWidth * 0.9, // Responsive width
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: screenWidth /
                            (screenHeight * 0.4), // Responsive aspect ratio
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          screenWidth * 0.05, // Responsive horizontal padding
                      vertical:
                          screenHeight * 0.01, // Responsive vertical padding
                    ),
                    child: MyProductCard(
                      data: product,
                      onAddToCart: () {},
                    ),
                  );
                },
              ),
              if (state.isLoading)
                const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
