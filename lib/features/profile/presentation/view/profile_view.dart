import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/profile/presentation/viewmodel/current_user_view_model.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(currentUserViewModelProvider.notifier).initialize());
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning,';
    } else if (hour < 17) {
      return 'Good Afternoon,';
    } else {
      return 'Good Evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFD29062),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _getGreeting(),
                style: TextStyle(
                  fontSize: size.width * 0.06,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              currentUserState.isLoading
                  ? const CircularProgressIndicator(color: Colors.black)
                  : currentUserState.error != null
                      ? Text(
                          currentUserState.error!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: size.width * 0.045,
                          ),
                        )
                      : Text(
                          currentUserState.authEntity?.username ??
                              'Username not fetched',
                          style: TextStyle(
                            fontSize: size.width * 0.06,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              const SizedBox(height: 40),
              SizedBox(
                width: size.width * 0.8,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to My Order page
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, size.height * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'My Order',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(double.infinity, size.height * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle Log Out action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        minimumSize: Size(double.infinity, size.height * 0.06),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: size.width * 0.045,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
