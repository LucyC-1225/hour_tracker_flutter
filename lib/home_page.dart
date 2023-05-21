import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hour_tracker/login_page.dart';
import 'package:hour_tracker/modify_entry_page.dart';
import 'package:hour_tracker/view_entry_page.dart';
import 'dart:io';

import 'add_hours_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.userEmail, required this.totalHours});

  final String userEmail;
  final int totalHours;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Home Page",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 40,
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      "Hello User!",
                      style: TextStyle(
                        fontSize: 30,
                      )
                    ),
                  ),
                  Container(
                    child: Text(
                      "Total Hours:",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "${widget.totalHours}",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 5,
                    indent: 20,
                    endIndent: 20,
                    color: Colors.green.shade900,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                    width: 100,
                    height: 100,
                    child: Image(image: NetworkImage("https://thumbs.dreamstime.com/b/stopwatch-timer-clock-icon-simple-vector-filled-flat-speed-face-green-solid-pictogram-isolated-white-background-169767085.jpg"))),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      var currentEntries;
                      FirebaseDatabase.instance.ref().child('users/${widget.userEmail.substring(0, widget.userEmail.indexOf("@"))}').once().then((value) {
                        currentEntries = value.snapshot.value;
                        print(currentEntries);
                        print(currentEntries.length);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewEntriesPage(userEmail: widget.userEmail, currentEntries: currentEntries,)),
                        );
                      }).catchError((onError) {
                        print("Failed to load :(");
                        print(onError.toString());
                      });
                    },
                    child: Text(
                      "View Entries",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade300
                    ),
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                  color: Colors.green.shade900,
                ),
                Container(
                  margin: EdgeInsets.only(top: 40, bottom: 20),
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: Text(
                      "Sign out",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHoursPage(userEmail: widget.userEmail)),
          ).then(onGoBack);
        },
        child: Icon(Icons.add),
        tooltip: "Add Hours",
      ),
    );
  }
}
