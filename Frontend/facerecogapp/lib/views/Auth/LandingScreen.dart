import 'package:facerecogapp/widgets/Buttons/StudentButton.dart';
import 'package:facerecogapp/widgets/Buttons/Teacher.dart';
import 'package:flutter/material.dart';

class Landingscreen extends StatefulWidget {
  const Landingscreen({super.key});

  @override
  State<Landingscreen> createState() => _LandingscreenState();
}

class _LandingscreenState extends State<Landingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: const Text(
                'Attendance Face Recognition App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            const Text('LOGO'),
            const SizedBox(
              height: 150,
            ),
            TeacherButton(
              buttonName: const Text(
                'Teacher',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              callback: () => Navigator.pushNamed(context, '/login'),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            const SizedBox(
              height: 20,
            ),
            Studentbutton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                buttonLabel: const Text(
                  'Student',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                callback: () => {debugPrint('helo')})
          ],
        ),
      )),
    );
  }
}
