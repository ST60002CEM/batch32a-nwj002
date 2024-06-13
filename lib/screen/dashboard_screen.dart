// import 'package:flutter/material.dart';
// import 'package:liquor_ordering_system/screen/login_screen.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});

//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFD29062),
//         title: const Text('Tipsy'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()),
//               );
//             },
//             icon: const Icon(Icons.exit_to_app),
//             color: Colors.white,
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFFD29062),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.black,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//       ),
//       // body: const Center(
//       //   child: Text(
//       //     'Dashboard Screen',
//       //     style: TextStyle(
//       //       fontSize: 24,
//       //       fontWeight: FontWeight.bold,
//       //       color: Color(0xFFD29062),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }
