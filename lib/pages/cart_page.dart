/*import 'package:flutter/material.dart';
/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}
*/
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String name = '';
  String mobileNumber = '';
  String pickupLocation = '';
  String carmodel ='Mercedes';
  String destination = '';
  String paymentMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ASU Way'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  mobileNumber = value;
                });
              },
              decoration: InputDecoration(labelText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  pickupLocation = value;
                });
              },
              decoration: InputDecoration(labelText: 'Pickup Location'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  destination = value;
                });
              },
              decoration: InputDecoration(labelText: 'destination'),
            ),


            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  carmodel = value;
                });
              },
              decoration: InputDecoration(labelText: 'car model'),
            ),
            SizedBox(height: 20),
            Text('Payment Method:'),
            Row(
              children: [
                Radio(
                  value: 'Visa',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value.toString();
                    });
                  },
                ),
                Text('Visa'),
                Radio(
                  value: 'Cash',
                  groupValue: paymentMethod,
                  onChanged: (value) {
                    setState(() {
                      paymentMethod = value.toString();
                    });
                  },
                ),
                Text('Cash'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                // Implement your confirmation logic here
                print('Name: $name');
                print('Mobile Number: $mobileNumber');
                print('Pickup Location: $pickupLocation');
                print('Destination: $destination');
                print('Payment Method: $paymentMethod');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, String>> drivers = [
    {
      'name': 'Ibrahim Amr',
      'source': 'Madinaty',
      'destination': 'ASU Gate 3',
      'carModel': 'Mercedes',
      'licensePlate': 'ABC1234',
      'carColor': 'Black',
      'timing': '8:00 AM',
    },

    // Add more drivers with similar structure
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Details'),
        backgroundColor: Colors.black, // Set the appbar background color to black
      ),
      backgroundColor: Colors.grey[300],
      body: Container(

        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Grey border
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Driver Name: ${drivers[index]['name']}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Source Location: ${drivers[index]['source']}'),
                    Text('Destination: ${drivers[index]['destination']}'),
                    SizedBox(height: 8),
                    Text('Car Information:'),
                    Text('Model: ${drivers[index]['carModel']}'),
                    Text('License Plate: ${drivers[index]['licensePlate']}'),
                    Text('Color: ${drivers[index]['carColor']}'),
                    SizedBox(height: 8),
                    Text('Timing: ${drivers[index]['timing']}'),
                    SizedBox(height: 12), // Adjust the button position
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black, // Change button color to green
                        ),
                        child: Text('Share the ride', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}