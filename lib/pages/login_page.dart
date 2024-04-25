import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:milestone2/component/button.dart';
import 'package:milestone2/component/textfield.dart';
import 'package:milestone2/pages/Sign_up.dart';
import 'package:milestone2/pages/home_page.dart';

import '../global/gobal.dart';
//import 'package:milestone1/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  validationForm(BuildContext context)
  {
    if(!_emailController.text.contains("@e")){
      Fluttertoast.showToast(msg: "Enter your email correctly");
    }

    else if(_passwordController.text.length<8){
      Fluttertoast.showToast(msg: "Password is incorrect..Please try again");
    }
    else{
     LoginUser(context);
    }
  }

  LoginUser(context) async
  {

    final User? firebaseUser = (
        // trim to avoid extra spaces
        await FAuth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context );
          Fluttertoast.showToast(msg: "Error :"+msg.toString());
        })
    ).user;

    if(firebaseUser != null)
    {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successfully.");
      Navigator.push(
        context  ,
        MaterialPageRoute(builder: (c) => (UserHomePage())),
        //MaterialPageRoute(builder: (c) => (MyHomePage())),
      );
    }
    else
    {
      Navigator.pop(context );
      Fluttertoast.showToast(msg: "Error while logging in, please try again...");
    }

  }

  //sign user in method
  void signUserIn(BuildContext context) {
    //  logic will be added here
    // For example, let's navigate to the home page

    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
    */
    validationForm(context);

  }



  void navigateToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Image.asset(
                  'assets/logo_1x.jpg', // Replace with the actual file path
                  width: 125, // Adjust the width as needed
                  height: 125, // Adjust the height as needed
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Share your ride & don\'t miss your Lecture!',
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(

                  onTap: () => signUserIn(context),
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),

                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),


               // const SizedBox(height: 50),

                // not a member? register now
                GestureDetector(
                  onTap: () => navigateToSignUpPage(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Sign Up now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ),

        ),
      ),
    );
  }
}

