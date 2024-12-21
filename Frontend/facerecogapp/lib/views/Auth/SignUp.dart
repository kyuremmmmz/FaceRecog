import 'package:facerecogapp/utils/Validatos.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:facerecogapp/widgets/InputFields/plaintext.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final middleInitial = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  Validatos? emailValidator;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    phoneController.dispose();
    _lastName.dispose();
    _firstName.dispose();
    middleInitial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Student Sign Up',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  Plaintext(
                      inputDecoration: const InputDecoration(
                          labelText: 'Enter your first name',
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (value) {
                        if (true) {
                          if (value.toString().isEmpty) {
                            return 'Please enter your firstName';
                          }
                        }
                        return null;
                      },
                      controller: _firstName,
                      type: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  Plaintext(
                      inputDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text('Enter your middle initial'),
                          floatingLabelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Middle initial is required';
                        }
                        if (value.toString().length > 4 - 1) {
                          return 'Middle initial is above 3 characters only';
                        }

                        return null;
                      },
                      controller: middleInitial,
                      type: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  Plaintext(
                      inputDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text('Enter your last name'),
                          floatingLabelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                      controller: _lastName,
                      type: TextInputType.name),
                  const SizedBox(
                    height: 20,
                  ),
                  Plaintext(
                      inputDecoration: const InputDecoration(
                          labelText: 'Enter your email address',
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                      validator: (value) {
                        final regex = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                        if (value.toString().isEmpty) {
                          return 'please enter your email';
                        } else if (!regex.hasMatch(value)) {
                          return 'please enter the valid email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 20,
                  ),
                  
                  Loginbutton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 67, 52, 209),
                          fixedSize: Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                          ),
                      buttonLabel: const Text(
                        'Sign up as Student',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      callback: () {
                        if (_key.currentState!.validate()) {
                          debugPrint('gago');
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
