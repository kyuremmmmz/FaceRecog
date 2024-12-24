import 'package:facerecogapp/controllers/AuthController.dart';
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
  @override
  void dispose() {
    super.dispose();
    _idController.dispose();
  }

  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Authcontroller>(context);
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
      drawer:  CustomDrawer(username: '${provider.user?.email}',),
      body: Center(
        child: Form(
          key: _form,
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Plaintext(
                      inputDecoration: InputDecoration(
                        labelText: 'Enter your ID',
                        floatingLabelStyle: TextStyle(
                          color: Colors.black
                          ),
                        border: OutlineInputBorder(),
                        focusColor: Colors.black,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                      controller: _idController,
                      type: TextInputType.text)
                ],
              )
          )
      ),
    );
  }
}
