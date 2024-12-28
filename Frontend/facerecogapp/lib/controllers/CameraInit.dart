import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:facerecogapp/views/AppScreens/ValidateAttendance.dart';
import 'package:facerecogapp/views/ImageScreen/ImageScreen.dart';
import 'package:flutter/material.dart';

class Camerainit {
  CameraController? _controller;

  CameraController? get controller => _controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw Exception('No cameras available');
    }
    final firstCam = cameras[1];
    _controller = CameraController(firstCam, ResolutionPreset.high);
    await _controller!.initialize();
  }

  Future<void> takePicture(
    BuildContext context,
    String firstName,
    String lastName,
    String middleInitial,
    String block,
    String email,
    String studentID,
    String password,
  ) async {
    try {
      final XFile pic = await controller!.takePicture();
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Imagescreen(
                    imagePath: pic.path,
                    firstName: firstName,
                    lastName: lastName,
                    middleInitial: middleInitial,
                    block: block,
                    email: email,
                    studentID: studentID,
                    password: password,
                  )));
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> takePictureValidation(
      BuildContext context, Uint8List file2,) async {
    try {
      final XFile pic = await controller!.takePicture();
      final Uint8List file = await pic.readAsBytes();
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Validateattendance(
                    imagePath: file,
                    file2: file2,
                  )));
    } catch (e) {
      print('Error taking picture: $e');
    }
  }
}
