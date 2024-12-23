import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/Auth/Camera.dart';
import 'package:facerecogapp/widgets/Buttons/ButtonWithIcon.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:facerecogapp/widgets/InputFields/password.dart';
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
  final student_id = TextEditingController();
  final yearBlock = TextEditingController();
  late List<CameraDescription> cameras;
  final Authcontroller controller = Authcontroller();
  late CameraController _cameraController;
  Future<void>? initialization;
  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    final firstCam = cameras.first;
    _cameraController = CameraController(firstCam, ResolutionPreset.high);
    initialization = _cameraController.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    phoneController.dispose();
    _lastName.dispose();
    _firstName.dispose();
    middleInitial.dispose();
    student_id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Student Registration',
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
                      inputDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text('Student ID 2024-2325-3 '),
                          floatingLabelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please enter your student ID';
                        }
                        if (value.toString().length != 13) {
                          return 'Student ID should be 13 characters long';
                        }
                        return null;
                      },
                      controller: student_id,
                      type: TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  Plaintext(
                      inputDecoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          label: Text('Year Block 3-A '),
                          floatingLabelStyle: TextStyle(color: Colors.black)),
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'please enter your year block';
                        }
                        if (value.toString().length != 3) {
                          return 'Year block should be 3 characters long';
                        }
                        return null;
                      },
                      controller: yearBlock,
                      type: TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  Plaintext(
                      inputDecoration: const InputDecoration(
                          labelText: 'Email JohnDoe23@example.com',
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
                  passwordTextField(
                      text: 'Password',
                      password: _passwordController,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Password is required';
                        }
                        if (value.toString().length < 8) {
                          return 'Password should be at least 8 characters long';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  passwordTextField(
                      text: 'Confirm Password',
                      password: _confirmPasswordController,
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (_confirmPasswordController.text ==
                            _passwordController.text) {
                          return null;
                        } else {
                          return 'Passwords do not match';
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Buttonwithicon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 67, 52, 209),
                          fixedSize: Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      icon: Icon(
                        Icons.face_6_sharp,
                        color: Colors.white,
                      ),
                      buttonLabel: const Text(
                        'Scan',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      callback: () {
                        if (cameras.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CameraScreen(),
                            ),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Loginbutton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 67, 52, 209),
                          fixedSize: Size(350, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
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
                          controller.registerUser(
                              _firstName.text.trim(),
                              _lastName.text.trim(),
                              middleInitial.text.trim(),
                              student_id.text.trim(),
                              yearBlock.text.trim(),
                              _emailController.text.trim(),
                              _passwordController.text.trim());
                        }
                      })
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
