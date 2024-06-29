import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/app/constants/api_endpoint.dart';
import 'package:liquor_ordering_system/features/home/domain/entity/product_entity.dart';

class MyProductCard extends StatelessWidget {
  final ProductEntity data;
  final VoidCallback onAddToCart;

  const MyProductCard(
      {required this.data, required this.onAddToCart, super.key});

  @override
  Widget build(BuildContext context) {
    final imageUrl = '${ApiEndpoints.imageUrl}${data.productImage}';

    return Column(
      children: [
        SizedBox(
          width: 318,
          height: 130, // Adjusted height to accommodate the button
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 318,
                  height: 99,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 1,
                top: 0,
                child: Container(
                  width: 81,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 15,
                child: Text(
                  data.productName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 106,
                top: 55,
                child: Text(
                  data.productPrice.toString(),
                  style: const TextStyle(
                    color: Color(0xFFD29062),
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              const Positioned(
                left: 81,
                top: 55,
                child: Text(
                  'Rs.',
                  style: TextStyle(
                    color: Color(0xFFD29062),
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 81,
                top: 35,
                child: Text(
                  '${data.productCategory}  |  5%',
                  style: const TextStyle(
                    color: Color(0xFF979797),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 45, // Adjusted top position to move the button higher
                child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add to Cart'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
