
import 'package:final_project/databaseHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_project/databaseHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DriverInfoPage(),
    );
  }
}
class DriverInfoPage extends StatefulWidget {
  const DriverInfoPage({super.key});

  @override
  _DriverInfoState createState() => _DriverInfoState();

}

class _DriverInfoState extends State<DriverInfoPage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<Map<String, dynamic>> myData =[];
  bool _isloading = false;

  @override
  void initState(){
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await DatabaseHelper.getUser(user.email!);
    setState((){
      myData = data;
      _isloading = false;
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Driver Name: John Doe',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            for (var data in myData)
              if (data.containsKey('Phone') && data['Phone'] != null)
                Text(
                  'Phone : ${data['Phone']}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
          ],
        ),
      ),
    );
  }

}
