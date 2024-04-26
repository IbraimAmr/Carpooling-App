import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedSeats;
  final List<String> seatOptions = ['1', '2', '3', '4', '5', '6']; // Add your options here
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedPickupLocation;
  final List<String> pickupLocations = ['Gate 3', 'Gate 4']; // Add your options here
  final DatabaseReference driversReference =
  FirebaseDatabase.instance.reference().child('drivers');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void registerRide() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null &&
        selectedDate != null &&
        selectedTime != null &&
        selectedPickupLocation != null &&
        selectedSeats != null) {
      String driverId = user.uid;

      driversReference.child(driverId).child('rides').push().set({
        'pickupLocation': selectedPickupLocation,
        'destination': destinationController.text,
        'date': DateFormat.yMd().format(selectedDate!),
        'time': selectedTime!.format(context),
        'price': priceController.text,
        'seats': selectedSeats,
      });
    } else {
      print('User not authenticated or date/time not selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverHomePage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pickup Location DropdownButton
              Row(
                children: [
                  Text('From: '),
                  DropdownButton<String>(
                    value: selectedPickupLocation,
                    items: pickupLocations
                        .map((location) => DropdownMenuItem<String>(
                      value: location,
                      child: Text(location),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPickupLocation = value;
                      });
                    },
                    hint: Text('Gate'),
                  ),
                ],
              ),

              // Destination TextField
              Row(
                children: [
                  Text('To: '),
                  Expanded(
                    child: TextField(
                      controller: destinationController,
                      decoration: InputDecoration(labelText: 'Enter Destination'),
                    ),
                  ),
                ],
              ),

              // Price TextField
              Row(
                children: [
                  Text('Price (EGP): '),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Enter Price (EGP)'),
                    ),
                  ),
                ],
              ),

              // Seats DropdownButton
              Row(
                children: [
                  Text('Number of Seats: '),
                  DropdownButton<String>(
                    value: selectedSeats,
                    items: seatOptions
                        .map((seats) => DropdownMenuItem<String>(
                      value: seats,
                      child: Text('$seats Seats'),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSeats = value;
                      });
                    },
                    hint: Text('Number of Seats'),
                  ),
                ],
              ),

              // Selected Date Text
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Date'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  if (selectedDate != null)
                    Text(
                      'Selected Date: ${DateFormat.yMd().format(selectedDate!)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                ],
              ),

              // Selected Time Text
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _selectTime(context),
                    child: Text('Select Time'),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  if (selectedTime != null)
                    Text(
                      'Selected Time: ${selectedTime!.format(context)}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                ],
              ),

              // Register Ride Button
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => registerRide(),
                  child: Text('Share the Ride'),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







