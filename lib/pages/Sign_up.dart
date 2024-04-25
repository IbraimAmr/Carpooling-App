import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../global/gobal.dart';
import 'login_page.dart'; // Make sure to import the necessary files

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  validationForm() {
    if (_nameController.text.length < 2) {
      Fluttertoast.showToast(msg: "Name must be more than 2 characters");
    } else if (!_emailController.text.contains("@eng.asu.edu.eg")) {
      Fluttertoast.showToast(msg: "Email address must be @eng.asu.edu.eg");
    } else if (_passwordController.text.length < 8) {
      Fluttertoast.showToast(msg: "Password must be at least 8 characters");
    } else if (_phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill in your phone number");
    } else {
      SaveUserInfo();
    }
  }

  SaveUserInfo() async {
    final User? firebaseUser = (
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        )
            .catchError((msg) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error :" + msg.toString());
        })
    ).user;

    if (firebaseUser != null) {
      Map userMap = {
        "id": firebaseUser.uid,
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneController.text.trim(),
      };
      DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child("users");
      userRef.child(firebaseUser.uid).set(userMap);

      // Assuming currentFirebaseUser is a global variable
      currentFirebaseUser = firebaseUser;

      Fluttertoast.showToast(msg: "Account has been created successfully");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => LoginPage()),
      );
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Account hasn't been created, please try again...");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validationForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
