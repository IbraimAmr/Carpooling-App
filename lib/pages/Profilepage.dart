import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

import '../global/gobal.dart'; // Add this import

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> driverid = {};
  bool isLoading = true; // Add a loading indicator

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await Firebase.initializeApp(); // Ensure Firebase is initialized
      await _retrieveDriverInfo();
    } catch (e) {
      print("Error initializing Firebase: $e");
    } finally {
      setState(() {
        isLoading = false; // Set loading to false when data retrieval is complete
      });
    }
  }

  Future<void> _retrieveDriverInfo() async {
    try {
      DatabaseReference driversRef = FirebaseDatabase.instance.reference().child("drivers");
      DatabaseReference userRef = driversRef.child(currentFirebaseUser!.uid);

      // Using the `once()` method to get a single snapshot
      DataSnapshot dataSnapshot = (await userRef.once()) as DataSnapshot;

      // Check if the snapshot value is not null and is a Map
      if (dataSnapshot.value != null && dataSnapshot.value is Map) {
        setState(() {
          driverid = Map<String, dynamic>.from(dataSnapshot.value as Map<dynamic, dynamic>);
        });
      } else {
        print("No valid data found for the driver");
      }
    } catch (e) {
      print("Error retrieving data from Firebase: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${driverid['name'] ?? ""}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${driverid['email'] ?? ""}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Phone: ${driverid['phone'] ?? ""}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Car Type: ${driverid['car_type'] ?? ""}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Car Plates: ${driverid['car_plates'] ?? ""}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}