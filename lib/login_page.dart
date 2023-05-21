import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hour_tracker/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hour_tracker/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 40,
            child: Image(
              image: NetworkImage("https://media.istockphoto.com/id/1246918676/photo/time.jpg?s=612x612&w=0&k=20&c=djviPk17yf2b6Kqk5rLfxCbpQAuYhkyfwTtgR7oZzXI="),
            ),
          ),
          Expanded(
            flex: 60,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "LOG IN",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    controller: emailController,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    controller: passwordController,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: Text("Forgot Password?"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupPage()),
                        );
                      },
                      child: Text("New user? Sign up"),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emailController.text, password: passwordController.text)
                          .then((value) {
                        print("Successfully logged in!");
                        int totalHours = 0;
                        var currentEntries;
                        FirebaseDatabase.instance.ref().child('users/${emailController.text.substring(0, emailController.text.indexOf("@"))}').once().then((value) {
                          setState(() {
                            currentEntries = value.snapshot.value;
                            if (currentEntries != null) {
                              int index = 0;
                              while (index < currentEntries.length) {
                                int hour = int.parse(currentEntries['entry${index + 1}']['hours']);
                                totalHours += hour;
                                index++;
                              }
                            }
                            print(totalHours);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage(userEmail: emailController.text, totalHours: totalHours,)),
                                  (Route<dynamic> route) => false,
                            );
                          });
                        }).catchError((onError) {
                          print("Failed to load :(");
                          print(onError.toString());
                        });
                      }).catchError((onError) {
                        print("Failed to sign up :(");
                        print(onError.toString());
                      });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.shade400
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
