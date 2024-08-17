import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cart_view_model.dart';

class CartView extends ConsumerStatefulWidget {
  const CartView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartViewState();
}

class _CartViewState extends ConsumerState<CartView> {
  @override
  void initState() {
    super.initState();
    ref.read(cartViewModelProvider.notifier).getCarts();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(cartViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final item = state.products[index];
                  return CartItemWidget(
                    // name: item.,
                    alcoholContent: '2%',
                    // price: item.productPrice.toString(),
                    quantity: 1,
                    onQuantityChanged: (newQuantity) {}, name: '', price: '',
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD29062), // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // Handle checkout action
                },
                child: const Text(
                  'Check Out',
                  style: TextStyle(
                    color: Colors.white, // Button text color
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final String name;
  final String alcoholContent;
  final String price;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    required this.name,
    required this.alcoholContent,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            'assets/images/ticon.png', // Placeholder image
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '1 | $alcoholContent',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD29062), // Price color
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    onQuantityChanged(quantity - 1);
                  }
                },
              ),
              Text(
                quantity.toString(),
                style: const TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  onQuantityChanged(quantity + 1);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
