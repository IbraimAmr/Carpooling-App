/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DatabaseReference usersReference =
  FirebaseDatabase.instance.reference().child('users');

  late User? _user;
  Map<String, dynamic>? _userData;
  List<Map<String, dynamic>> _userRides = [];

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _fetchUserData();
      _fetchUserRides();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      usersReference.child(_user!.uid).onValue.listen((event) {
        DataSnapshot dataSnapshot = event.snapshot;
        if (dataSnapshot.value != null) {
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

  Future<void> _fetchUserRides() async {
    try {
      DataSnapshot snapshot = (await usersReference
          .child(_user!.uid)
          .child('rides') // Assuming 'rides' is the key for user rides
          .once()) as DataSnapshot;

      if (snapshot.value != null) {
        List<Map<String, dynamic>> userRides = [];

        Object? ridesData = snapshot.value;
        ridesData?.forEach((key, value) {
          userRides.add(Map<String, dynamic>.from(value));
        });

        setState(() {
          _userRides = userRides;
        });
      }
    } catch (error) {
      print('Error fetching user rides: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride History'),
      ),
      body: _userData != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${_userData!['name'] ?? 'N/A'}'),
            Text('Email: ${_userData!['email'] ?? 'N/A'}'),
            SizedBox(height: 20),
            Text('Ride History:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _userRides.isNotEmpty
                ? Column(
              children: _userRides.map((rideDetails) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Pickup Location: ${rideDetails['pickupLocation'] ?? 'N/A'}'),
                        Text('Destination: ${rideDetails['destination'] ?? 'N/A'}'),
                        Text('Date: ${rideDetails['date'] ?? 'N/A'}'),
                        Text('Time: ${rideDetails['time'] ?? 'N/A'}'),
                        Text('Price: ${rideDetails['price'] ?? 'N/A'}'),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
                : Text('No ride history available.'),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
*/
