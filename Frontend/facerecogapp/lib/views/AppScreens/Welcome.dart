import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/AiController.dart';
import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/AppScreens/AttendanceCamera.dart';
import 'package:facerecogapp/widgets/Buttons/ButtonWithIcon.dart';
import 'package:facerecogapp/widgets/Buttons/LoginButton.dart';
import 'package:facerecogapp/widgets/InputFields/plaintext.dart';
import 'package:facerecogapp/widgets/NavigationDrawer/Drawers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final _idController = TextEditingController();
  final _form = GlobalKey<FormState>();
  late List<CameraDescription> cameras = [];
  late CameraController _cameraController;
  Future<void>? initialization;
  String? image;

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    final firstCam = cameras[1];
    _cameraController = CameraController(firstCam, ResolutionPreset.high);
    initialization = _cameraController.initialize();
    setState(() {}); 
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> _submit(String studentID) async {
    await Provider.of<AiController>(context, listen: false).getImage(studentID);
    setState(() {
      image = studentID;
    });
  }


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authcontroller>(context);
    final aiProvider = Provider.of<AiController>(context);
    String? base64Image = aiProvider.user?.imagePath;
    Uint8List? imageData;
    try {
      if (base64Image != null && base64Image.isNotEmpty) {
        String cleanedBase64String =
            base64Image.replaceFirst('data:image/jpeg;base64,', '');
        imageData = base64Decode(cleanedBase64String);
      }
    } catch (e) {
      print('Error decoding image: $e');
      imageData = null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      drawer: CustomDrawer(
        username: '${provider.user?.email}',
      ),
      body: Center(
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageData != null
                  ? SizedBox(
                      height: 200,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.memory(
                              imageData,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(
                      height: 200,
                      child: Center(
                        child: Text('No Image Found'),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              Plaintext(
                inputDecoration: InputDecoration(
                  labelText: 'Enter your ID',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
                controller: _idController,
                type: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              Loginbutton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color.fromARGB(255, 67, 52, 209)),
                buttonLabel: const Text(
                  'Submit',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                callback: () {
                  _submit(_idController.text.trim());
                },
              ),
              Buttonwithicon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      fixedSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  icon: Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  ),
                  buttonLabel: const Text(
                    'Next',
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
                            builder: (context) => Attendancecamera(file1: imageData!,
                          ),
                        )
                        );
                      }
                    
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
