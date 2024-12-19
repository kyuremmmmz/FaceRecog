# Flutter App Architecture Example

This document demonstrates a complete Flutter app architecture that integrates frontend, backend, and state management. The app follows a **clean architecture** approach, ensuring modularity and scalability.

---

## **Directory Structure**

```plaintext
lib/
│
├── models/          # Data models (e.g., User, Product)
│   └── user.dart
│
├── views/           # Screens and UI components
│   ├── home_screen.dart
│   └── login_screen.dart
│
├── controllers/     # State management (e.g., Provider or BLoC)
│   └── auth_controller.dart
│
├── services/        # Backend API calls (e.g., REST, Supabase)
│   └── api_service.dart
│
├── widgets/         # Reusable UI components
│   └── custom_button.dart
│
├── utils/           # Helpers (e.g., Validators, Extensions)
│   └── validators.dart
│
└── main.dart        # App entry point
```

---

## **Code Implementation**

### **1. Models**
Define the `User` data model.

`models/user.dart`:
```dart
class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
```

---

### **2. Services**
Create an API service for backend interaction.

`services/api_service.dart`:
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://api.example.com';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to log in');
    }
  }
}
```

---

### **3. Controllers**
Manage state using `ChangeNotifier` (Provider pattern).

`controllers/auth_controller.dart`:
```dart
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;

  User? get user => _user;

  Future<void> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      _user = User.fromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
```

---

### **4. Views**

#### Login Screen
`views/login_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authController.login(
                    emailController.text,
                    passwordController.text,
                  );
                  Navigator.pushNamed(context, '/home');
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed: $e')),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Home Screen
`views/home_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${authController.user?.name ?? 'Guest'}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

### **5. Main Entry Point**

`main.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'views/login_screen.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthController(),
      child: MaterialApp(
        title: 'Flutter App Architecture',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
```

---

### **Key Features**
1. **Separation of Concerns**: Clear distinction between models, views, controllers, and services.
2. **Scalable Architecture**: Easy to extend as the app grows.
3. **State Management**: Provider pattern ensures reactivity and performance.
4. **Backend Integration**: Services layer handles API calls.

This architecture ensures a clean, maintainable, and scalable Flutter app.
