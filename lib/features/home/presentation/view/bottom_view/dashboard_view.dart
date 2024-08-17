import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/core/common/my_product_card.dart';
import 'package:liquor_ordering_system/core/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cart_view_model.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/home_viewmodel.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/products_viewmodel.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  final ScrollController _scrollController = ScrollController();
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  List imageList = [
    {"id": 1, "image_path": 'assets/images/s1.jpg'},
    {"id": 2, "image_path": 'assets/images/s2.jpg'},
    {"id": 3, "image_path": 'assets/images/s3.jpg'}
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  void dispose() {
    _scrollController.dispose();
    for (final subscription in _streamSubscription) {
      subscription.cancel(); // Cancel all stream subscriptions
    }
    super.dispose();
  }

  @override
  void initState() {
    _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
        _checkGyroscopeValues(_gyroscopeValues);
      });
    }));
    super.initState();
  }

  void _checkGyroscopeValues(List<double> values) async {
    const double threshold = 3; // Example threshold value, adjust as needed
    if (values.any((value) => value.abs() > threshold)) {
      if (showYesNoDialog && !isDialogShowing) {
        isDialogShowing = true;
        final result = await AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          title: 'Logout',
          desc: 'Are You Sure You Want To Logout?',
          btnOkOnPress: () {
            ref.read(homeViewModelProvider.notifier).logout();
          },
          btnCancelOnPress: () {},
        ).show();

        isDialogShowing = false;
        if (result) {
          mySnackBar(
            message: 'Logged Out Successfully!',
            color: Colors.green,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productViewModelProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Getting the CartViewModel instance from the provider
    final cartViewModel = ref.read(cartViewModelProvider.notifier);

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              _scrollController.position.extentAfter == 0) {
            ref.read(productViewModelProvider.notifier).getProducts();
          }
          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Carousel with Image Slides
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      // Handle carousel item tap
                    },
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: screenWidth * 0.9, // Responsive width
                                height: screenHeight *
                                    0.25, // Fixed height to 25% of screen
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2.0, // Adjust for different screen sizes
                        viewportFraction: 0.95,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          if (mounted) {
                            setState(() {
                              currentIndex = index;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Explore Categories Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Explore Categories',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Navigate to the Categories page
                      },
                      child: const Text(
                        'Show all',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Category Icons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return Container(
                      width: screenWidth * 0.2, // 20% of the screen width
                      height: screenHeight * 0.1, // 10% of the screen height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/ticon.png'), // Replace with your category images
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Featured Products',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              // List of Products
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the product details page when the card is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailView(product: product),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            screenWidth * 0.05, // Responsive horizontal padding
                        vertical:
                            screenHeight * 0.01, // Responsive vertical padding
                      ),
                      child: MyProductCard(
                        data: product,
                        onAddToCart: () async {
                          // Call the addCart method with product details
                          await cartViewModel.addCart(
                            "userID", // Replace with actual userID
                            product.id
                                .toString(), // Convert product ID to string
                            1, // Assuming quantity is 1
                          );

                          mySnackBar(
                            message: 'Product added to cart',
                            color: Colors.green,
                          );
                        },
                      ),
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

// Example of a Product Detail Page
class ProductDetailView extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailView({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              '${ApiEndpoints.imageUrl}${product.productImage}',
              fit: BoxFit.contain, // Display the full image without cutting
              width: double.infinity,
              height: 200,
            ),
            const SizedBox(height: 16),
            Text(
              product.productName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${product.productCategory} | 5%',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Rs. ${product.productPrice}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD29062),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add the product to the cart
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: const Color(0xFFD29062),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
