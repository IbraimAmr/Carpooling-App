import 'package:final_project/databaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:final_project/global/gobal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:final_project/pages/Login.dart';
import 'package:final_project/databaseHelper.dart';

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
  TextEditingController _carTypeController = TextEditingController();
  TextEditingController _carPlatesController = TextEditingController();
  List<Map<String, dynamic>> myData =[];
  bool _isloading = true;


  validationForm() async {
    if (_nameController.text.length < 2) {
      Fluttertoast.showToast(msg: "Name must be more than 2 characters");
    } else if (!_emailController.text.contains("@eng.asu.edu.eg")) {
      Fluttertoast.showToast(msg: "Email address must be @eng.asu.edu.eg ");
    } else if (_passwordController.text.length < 8) {
      Fluttertoast.showToast(msg: "Password must be at least 8 characters");
    } else if (_phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill in your phone number");
    } else if (_carTypeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill in the type of car");
    } else if (_carPlatesController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Fill in the car plates");
    } else {

      SavedriverInfo();

    }
  }

  SavedriverInfo() async {

    final User? firebaseUser = (
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        )
            .catchError((msg) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error: " + msg.toString());
        })
    ).user;

    if (firebaseUser != null) {
      Map drivermap = {
        "id": firebaseUser.uid,
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "phone": _phoneController.text.trim(),
        "car_type": _carTypeController.text.trim(),
        "car_plates": _carPlatesController.text.trim(),
      };
      DatabaseReference userRef =
      FirebaseDatabase.instance.ref().child("drivers");
      userRef.child(firebaseUser.uid).set(drivermap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created successfully");
      print(_phoneController);
      //await addItem();
      print("data saved");
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


  Future<void> addItem() async{
    await DatabaseHelper.createItem(_nameController.text, _emailController.text,  _phoneController.text,
        _carTypeController.text);
    _refreshData();
    print("data saved akheran");
  }
  void _refreshData() async{
    final data = await DatabaseHelper.getItems();
    setState(() {
      myData = data;
      _isloading = false;

    });
  }

  @override
  void initState(){
    super.initState();
    _refreshData();
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
              TextField(
                controller: _carTypeController,
                decoration: InputDecoration(labelText: 'Type of Car'),
              ),
              TextField(
                controller: _carPlatesController,
                decoration: InputDecoration(labelText: 'Car Plates (3 letters and 3 numbers)'),
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
                child: Text('Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

