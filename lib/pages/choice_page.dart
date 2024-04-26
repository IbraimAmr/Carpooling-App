import 'package:flutter/material.dart';
import 'Profilepage.dart';
import 'home_page.dart';
import 'home_page2.dart';
import 'profile_page.dart'; // Import your profile page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Choice Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChoicePage(),
    );
  }
}

class ChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Offer A Ride'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(
                  //builder: (context) => DriverInfoPage(),
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverHomePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('From ASU', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverHomePage2(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('TO ASU', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
