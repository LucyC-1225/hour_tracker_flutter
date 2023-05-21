import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
                    "SIGN UP",
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
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text, password: passwordController.text)
                      .then((value) {
                        print("Successfully Signed up!");
                        Navigator.pop(context);
                      }).catchError((onError) {
                        print("Failed to sign up :(");
                        print(onError.toString());
                      });
                    },
                    child: Text(
                        "Signup",
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
