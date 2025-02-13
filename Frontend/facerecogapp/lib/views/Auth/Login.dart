import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:facerecogapp/widgets/InputFields/email.dart';
import 'package:facerecogapp/widgets/InputFields/password.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final passswordController = TextEditingController();
  bool isLoading = false;
  Authcontroller? authControllerProvider;
  @override
  void dispose() {
    super.dispose();
    passswordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authControllerProvider = Provider.of<Authcontroller>(context);
    Future<void> loginUser() async {
      setState(() {
        isLoading = true;
      });
      try {
        await authControllerProvider?.loginUser(
          context,
          _emailController.text.trim(),
          passswordController.text.trim(),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Login failed: ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Teacher Login',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  Email(
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  passwordTextField(
                    text: 'Password',
                    password: passswordController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Loginbutton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(350, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromARGB(255, 67, 52, 209)),
                      buttonLabel: Text(
                        isLoading == true ? 'Loading' : 'Login',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      callback: () async {
                        if (_form.currentState!.validate()) {
                          loginUser();
                        }
                      })
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text(
                "Don't have an account? Sign up",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      )),
    );
  }
}
