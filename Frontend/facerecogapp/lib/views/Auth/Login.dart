import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:facerecogapp/widgets/InputFields/email.dart';
import 'package:facerecogapp/widgets/InputFields/password.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final passswordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    passswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              'Student Login',
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
                          borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: const Color.fromARGB(255, 67, 52, 209)
                      ), buttonLabel: const Text('Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ), 
                    callback: (){
                        if (_form.currentState!.validate()) {
                          debugPrint('bisaya');
                        }
                      }
                    )
                ],
              ),
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
