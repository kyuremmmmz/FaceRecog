import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:facerecogapp/controllers/AiController.dart';
import 'package:facerecogapp/controllers/AuthController.dart';
import 'package:facerecogapp/views/AppScreens/AttendanceCamera.dart';
import 'package:facerecogapp/widgets/Buttons/ButtonWithIcon.dart';
import 'package:facerecogapp/widgets/NavigationDrawer/Drawers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
  int _currentIndex = 0;

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final firstCam = cameras[1];
      _cameraController = CameraController(firstCam, ResolutionPreset.high);
      initialization = _cameraController.initialize();
      setState(() {});
    } else {
      print("No cameras available");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
    _cameraController.dispose();
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authcontroller>(context);
    final aiProvider = Provider.of<AiController>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    String? base64Image = aiProvider.user?.imagePath;
    Uint8List? imageData;
    Uint8List? image;
    String? base64 = provider.user?.imagePath;

    try {
      if (base64 != null && base64.isNotEmpty) {
        String clean = base64.replaceFirst('data:image/jpeg;base64,', '');
        image = base64Decode(clean);
      }
    } catch (e) {
      print('Error decoding image: $e');
      image = null;
    }

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
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Home',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        ),),
        backgroundColor: const Color(0xFF1C75BB),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: CircleAvatar(
                  backgroundImage: MemoryImage(image!),
                ),
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              )),
        ],
      ),
      drawer: CustomDrawer(
        profilePicture: image,
        name: '${provider.user?.firstName} ${provider.user?.lastName}',
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
                image.isNotEmpty
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: MemoryImage(image),
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
                const SizedBox(height: 20),
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
                    String title;
                    IconData icon;
                    switch (index) {
                      case 0:
                        title = 'Appeals';
                        icon = Icons.warning;
                        break;
                      case 1:
                        title = 'Grades';
                        icon = Icons.grade;
                        break;
                      case 2:
                        title = 'Schedule';
                        icon = Icons.schedule;
                        break;
                      case 3:
                        title = 'Tuition';
                        icon = Icons.monetization_on;
                        break;
                      case 4:
                        title = 'Subjects';
                        icon = Icons.subject;
                        break;
                      case 5:
                        title = 'Enlist';
                        icon = Icons.assignment;
                        break;
                      default:
                        title = 'Unknown';
                        icon = Icons.help;
                        break;
                    }
                    return GestureDetector(
                      onTap: () {
                        print('Tapped on $title');
                      },
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
                              icon,
                              size: 40,
                              color: Colors.blue,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              title,
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
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Student ID: ${provider.user!.studentID}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Block: ${provider.user!.block}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        StreamBuilder<DateTime>(
                          stream: Stream.periodic(
                              Duration(seconds: 1), (_) => DateTime.now()),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('Loading...');
                            }
                            final formattedDate =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(snapshot.data!);
                            return Text(
                              'Date Today: $formattedDate',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Buttonwithicon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(250, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  buttonLabel: const Text(
                    'Attendance',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  callback: () {
                    if (cameras.isNotEmpty && image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Attendancecamera(file1: image!),
                        ),
                      );
                    } else {
                      print("Image or camera not available");
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
