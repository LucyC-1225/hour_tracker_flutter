import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class AddHoursPage extends StatefulWidget {
  const AddHoursPage({super.key, required this.userEmail});

  final String userEmail;

  @override
  State<AddHoursPage> createState() => _AddHoursPageState();

}

class _AddHoursPageState extends State<AddHoursPage> {
  final controllerA = TextEditingController();
  final controllerB = TextEditingController();
  final controllerC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Add Hours",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 25, bottom: 5),
              child: Text(
                "Date (MM/DD/YYYY)",
                style: TextStyle(
                  fontSize: 20,

                ),
              ),
            ),
            Container(
              width: 380,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the Date:',
                ),
                controller: controllerA,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Total hours",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              width: 380,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter the total hours:',
                ),
                controller: controllerB,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Description/Notes",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
            Container(
              width: 380,
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                controller: controllerC,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  //instead of adding to hourEntriesList, this should go into database
                  var entry = {
                    'date' : controllerA.text,
                    'hours' : controllerB.text,
                    'description' : controllerC.text
                  };

                  var currentEntries;
                  FirebaseDatabase.instance.ref().child('users/${widget.userEmail.substring(0, widget.userEmail.indexOf("@"))}').once().then((value) {
                    print(value.snapshot.value);
                    currentEntries = value.snapshot.value;

                    if(currentEntries == null) {
                      currentEntries = {};
                    }

                    FirebaseDatabase.instance.ref().child('users/${widget.userEmail.substring(0, widget.userEmail.indexOf("@"))}/entry${currentEntries.length + 1}').set(
                        entry
                    ).then((value) {
                      print("Successfully added!");
                      int totalHours = 0;
                      var currentEntries;
                      FirebaseDatabase.instance.ref().child('users/${widget.userEmail.substring(0, widget.userEmail.indexOf("@"))}').once().then((value) {
                        setState(() {
                          currentEntries = value.snapshot.value;
                          int index = 0;
                          while (index < currentEntries.length) {
                            int hour = int.parse(currentEntries['entry${index + 1}']['hours']);
                            totalHours += hour;
                            index++;
                          }
                          print(totalHours);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(userEmail: widget.userEmail, totalHours: totalHours,)),
                                (Route<dynamic> route) => false,
                          );
                        });
                      }).catchError((onError) {
                        print("Failed to load :(");
                        print(onError.toString());
                      });
                    }).catchError((onError) {
                      print("Failed to add :(");
                      print(onError.toString());
                    });
                  }).catchError((onError) {
                    print("Failed to load :(");
                    print(onError.toString());
                  });
                },
                child: Text(
                  "Add Entry",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen.shade300
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
