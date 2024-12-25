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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    String? base64Image = aiProvider.user?.imagePath;
    Uint8List? imageData;
    try {
      if (base64Image != null && base64Image.isNotEmpty) {
        String cleanedBase64String = base64Image.replaceFirst('data:image/jpeg;base64,', '');
        imageData = base64Decode(cleanedBase64String);
      }
    } catch (e) {
      print('Error decoding image: $e');
      imageData = null;
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0xFF1C75BB),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.person, color: Colors.blue),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ),
        ],
      ),
      endDrawer: CustomDrawer(
        username: '${provider.user?.email}',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1C75BB), Color(0xFF0A509F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Display Image if available
                imageData != null
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: MemoryImage(imageData),
                      )
                    : const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                const SizedBox(height: 20),

                // Main action grid buttons
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.money, // Placeholder icon
                              size: 40,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Action ${index + 1}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Plaintext(
                          inputDecoration: InputDecoration(
                            labelText: 'Enter your ID',
                            labelStyle: TextStyle(color: Colors.black),
                            floatingLabelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            suffixIcon: Icon(Icons.search, color: Colors.black),
                          ),
                          controller: _idController,
                          type: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        Loginbutton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(350, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: const Color(0xFF4E73DF),
                          ),
                          buttonLabel: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          callback: () {
                            _submit(_idController.text.trim());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Buttonwithicon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  icon: Icon(
                    Icons.arrow_forward_ios,
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
                          builder: (context) =>
                              Attendancecamera(file1: imageData!),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
