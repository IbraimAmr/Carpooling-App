
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:milestone2/pages/login_page.dart';
import 'cart_page.dart'; // Import the DriverDetailsPage
import 'histroy_page.dart'; // Import the HistoryPage
import 'profile_page.dart'; // Import the ProfilePage

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final DatabaseReference usersReference =
  FirebaseDatabase.instance.reference().child('users');

  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredRides = [];
  var driversList = []; // Add this variable to store drivers list

  void navigateToDriverDetailsPage(
      BuildContext context, String driverId, String driverName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DriverDetailsPage(
          rideDetails: {}, // Pass the relevant rideDetails
          selectedDriverId: '',
          driverId: driverId,
          driverName: driverName, // Pass the driver name to the new page
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Available Routes'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              // Navigate to the history page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
              onChanged: (value) {
                // Implement your search functionality here
                filterRides(value);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDatabase.instance
                  .reference()
                  .child('drivers')
                  .onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
                  var drivers = snapshot.data!.snapshot.value! as Map?;
                  if (drivers != null) {
                    // Store drivers list for filtering
                    driversList = drivers.values.toList();

                    return ListView.builder(
                      itemCount: drivers.length,
                      itemBuilder: (context, index) {
                        var driver = drivers.values.elementAt(index);
                        String driverId = drivers.keys.elementAt(index);

                        return StreamBuilder(
                          stream: FirebaseDatabase.instance
                              .reference()
                              .child('drivers')
                              .child(driverId)
                              .child('rides')
                              .onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                snapshot.data?.snapshot.value != null) {
                              var ridesMap =
                              snapshot.data!.snapshot.value as Map?;
                              if (ridesMap != null) {
                                List ridesList = ridesMap.values.toList();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var rideDetails in ridesList) ...[
                                      Card(
                                        margin: EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () =>
                                              navigateToDriverDetailsPage(
                                                context,
                                                driverId,
                                                driver['name'] ?? 'N/A',
                                              ),
                                          child: ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Pickup Location: ${rideDetails['pickupLocation'] ?? 'N/A'}'),
                                                Text(
                                                    'Destination: ${rideDetails['destination'] ?? 'N/A'}'),
                                                Text(
                                                    'Date: ${rideDetails['date'] ?? 'N/A'}'),
                                                Text(
                                                    'Time: ${rideDetails['time'] ?? 'N/A'}'),
                                                Text(
                                                    'Price: ${rideDetails['price'] ?? 'N/A'}'), // Display ride price
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                );
                              }
                            }

                            // If there's no data or rides, show an empty state
                            return Container();
                          },
                        );
                      },
                    );
                  }
                }

                // If there's no data or rides, show an empty state
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterRides(String searchTerm) {
    filteredRides.clear();

    if (searchTerm.isEmpty) {
      setState(() {});
      return;
    }

    // Filter rides based on the first letter of pickup location and destination
    for (var driver in driversList) {
      for (var rideDetails in driver['rides']) {
        String pickupLocation =
            rideDetails['pickupLocation'] ?? 'N/A';
        String destination =
            rideDetails['destination'] ?? 'N/A';

        if (pickupLocation.toLowerCase().startsWith(searchTerm.toLowerCase()) ||
            destination.toLowerCase().startsWith(searchTerm.toLowerCase())) {
          filteredRides.add(rideDetails);
        }
      }
    }

    setState(() {});
  }
}










