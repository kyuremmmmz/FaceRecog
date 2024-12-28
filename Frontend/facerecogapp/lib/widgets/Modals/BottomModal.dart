import 'package:facerecogapp/controllers/AttendanceController.dart';
import 'package:facerecogapp/views/AppScreens/Welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomModal {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController id = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final TextEditingController? remarks = TextEditingController();
  Future<void> modal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        final provider = Provider.of<AttendanceController>(context);
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Attendance Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: id,
                decoration: InputDecoration(
                  labelText: 'Teacher ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: subject,
                decoration: InputDecoration(
                  labelText: 'Subect Code attended',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: remarks,
                decoration: InputDecoration(
                  labelText: 'Remarks (Optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  provider.attend(
                    id.text.trim(), 
                    DateTime.now().toString(),
                    'present', subject.text.trim()
                    );
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void dispose() {
    nameController.dispose();
    id.dispose();
    subject.dispose();
  }
}
