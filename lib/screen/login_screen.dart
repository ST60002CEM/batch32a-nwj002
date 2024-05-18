// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/common/my_snack_bar.dart';
import 'package:liquor_ordering_system/screen/dashboard_screen.dart';
import 'package:liquor_ordering_system/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureTextPassword = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                    child: Image(
                      image: const AssetImage(
                        "assets/images/ticon.png",
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.6,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome Back to Tipsy",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      fontSize: 26,
                      color: Color(0xFFD29062),
                    ),
                  ),
                  const Text(
                    "Online Liquor Store",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 15,
                      color: Color(0xFFD29062),
                    ),
                  ),
                  // this is email section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Is Required';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Color(0x00ffffff), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                                color: Color(0x00ffffff), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(
                              color: Color(0x00ffffff),
                              width: 1,
                            ),
                          ),
                          hintText: "Email",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff9f9d9d),
                          ),
                          filled: true,
                          fillColor: const Color(0x21ffc107),
                          isDense: false,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          prefixIcon: const Icon(Icons.mail,
                              color: Color(0xFFD29062), size: 24)),
                    ),
                  ),
// this is password section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureTextPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14,
                        color: Color(0xff000000),
                      ),
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color(0x00ffffff), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color(0x00ffffff), width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(
                              color: Color(0x00ffffff), width: 1),
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff9f9d9d),
                        ),
                        filled: true,
                        fillColor: const Color(0x21ffc107),
                        isDense: false,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        prefixIcon: const Icon(Icons.lock,
                            color: Color(0xFFD29062), size: 24),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              _obscureTextPassword = !_obscureTextPassword;
                            });
                          },
                          child: Icon(
                            _obscureTextPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20.0,
                            color: const Color(0xFFD29062),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // this is forgot password section
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot Password?",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xFFD29062),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // this is login button section
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 16),
                    child: MaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            MySnackBar(
                                message: "Login Successfully",
                                context: context,
                                color: Colors.green);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DashboardScreen()),
                            );
                          }
                        },
                        color: const Color(0xFFD29062),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0xffffffff),
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        )),
                  ),
                  // this is don't have an account section
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Don't Have an account?",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xff000000),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0xFFD29062),
                              ),
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
        ),
      ),
    );
  }
}

// class ValidateLogin {
//   static String? emailValidate(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Email is required";
//     }

//     return null;
//   }

//   static String? password(String? value) {
//     if (value == null || value.isEmpty) {
//       return "Password is required";
//     }
//     return null;
//   }
// }
