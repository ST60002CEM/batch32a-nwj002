import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquor_ordering_system/features/home/presentation/viewmodel/cureent_user_viewmodel.dart';

class EditProfileView extends ConsumerWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserState = ref.watch(currentUserViewModelProvider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: currentUserState.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black),
              )
            : currentUserState.error != null
                ? Center(
                    child: Text(
                      currentUserState.error!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: size.width * 0.045,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      _buildTextField(
                        label: 'Full Name',
                        initialValue:
                            currentUserState.authEntity?.fullname ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Email',
                        initialValue: currentUserState.authEntity?.email ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Phone',
                        initialValue:
                            currentUserState.authEntity?.phone.toString() ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Username',
                        initialValue:
                            currentUserState.authEntity?.username ?? '',
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        label: 'Age',
                        initialValue:
                            currentUserState.authEntity?.age.toString() ?? '',
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add update logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFD29062), // Update button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 18,
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

  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.orange, // Label text color
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.orange),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.orange),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.orange),
        ),
      ),
    );
  }
}
