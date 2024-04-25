import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DriverDetailsPage extends StatefulWidget {
  final Map<String, dynamic> rideDetails;
  final String selectedDriverId;
  final String driverId;
  final String driverName;

  DriverDetailsPage({
    required this.rideDetails,
    required this.selectedDriverId,
    required this.driverId,
    required this.driverName,
  });

  @override
  _DriverDetailsPageState createState() => _DriverDetailsPageState();
}

class _DriverDetailsPageState extends State<DriverDetailsPage> {
  Map<dynamic, dynamic>? driverDetails;
  String selectedPaymentMethod = 'Cash';

  @override
  void initState() {
    super.initState();
    _fetchDriverDetails();
  }

  Future<void> _fetchDriverDetails() async {
    try {
      DatabaseEvent event = await FirebaseDatabase.instance
          .reference()
          .child('drivers')
          .child(widget.driverId)
          .once();

      DataSnapshot dataSnapshot = event.snapshot;

      setState(() {
        driverDetails = dataSnapshot.value as Map<dynamic, dynamic>?;
      });
    } catch (error) {
      print('Error fetching driver details: $error');
    }
  }

  Future<void> _saveRideToUserDatabase(String userId) async {
    try {
      DatabaseReference userRidesRef =
      FirebaseDatabase.instance.reference().child('users/$userId/rides');

      // Customize the ride data as needed
      Map<String, dynamic> rideData = {
        'driverId': widget.driverId,
        'driverName': widget.driverName,
        'paymentMethod': selectedPaymentMethod,
        // Add more ride-related details
      };

      // Push the ride data to the user's 'rides' node
      DatabaseReference newRideRef = userRidesRef.push();
      await newRideRef.set(rideData);

      // You can also perform any additional actions after saving the ride

      print('Ride saved successfully!');
    } catch (error) {
      print('Error saving ride: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: driverDetails != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Driver Name: ${widget.driverName}',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Driver Email: ${driverDetails!['email'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Driver Phone: ${driverDetails!['phone'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Car Type: ${driverDetails!['car_type'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              'Car Plates: ${driverDetails!['car_plates'] ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            // Payment method dropdown
            Text(
              'Select Payment Method:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
              items: ['Cash', 'Visa'].map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),
            SizedBox(height: 16),
            Spacer(),
            // Use Container to make the button span the width and set the color
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Retrieve the currently logged-in user
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    _saveRideToUserDatabase(user.uid);
                  } else {
                    print('User not logged in');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Set button color to black
                ),
                child: Text(
                  'Confirm Ride',
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ),
          ],
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
