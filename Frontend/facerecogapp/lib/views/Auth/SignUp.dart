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
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Form(
              key: _key,
              child: Column(
                children: [
                  Plaintext(
                      inputDecoration: const InputDecoration(
                        labelText: 'Enter your name',
                        floatingLabelStyle: TextStyle(
                          color: Colors.black
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black
                          )
                          )
                        ),
                      validator: (value) {
                        if (value) {
                          if (value.toString().isEmpty) {
                            return 'Please enter your name';
                          }
                        }
                        return null;
                      },
                      controller: _emailController,
                      type: TextInputType.text
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
