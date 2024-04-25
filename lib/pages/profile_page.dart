import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final DatabaseReference usersReference =
  FirebaseDatabase.instance.reference().child('users');

  late User? _user;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      // Use onValue to listen for changes and retrieve a DatabaseEvent
      usersReference.child(_user!.uid).onValue.listen((event) {
        // Extract DataSnapshot from DatabaseEvent
        DataSnapshot dataSnapshot = event.snapshot;

        // Check if the snapshot has data
        if (dataSnapshot.value != null) {
          // Convert dynamic to Map<String, dynamic>
          Map<String, dynamic> userData =
          (dataSnapshot.value as Map<dynamic, dynamic>)
              .cast<String, dynamic>();

          setState(() {
            _userData = userData;
          });
        }
      });
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Profile'),
      ),
      body: _userData != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text('User ID: ${_user!.uid}'),
            Text(
              'Name: ${_userData!['name'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 28, // Set the desired font size
                fontWeight: FontWeight.bold,
              ),
            ),

            Text('Email: ${_userData!['email'] ?? 'N/A'}',
              style: TextStyle(
              fontSize: 18, // Set the desired font size

            ),),
            Text('Phone number: ${_userData!['phone'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18, // Set the desired font size

              ),),

            // Display additional user-related details
            // Add more fields as needed
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
