import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ViewEntriesPage extends StatefulWidget {
  const ViewEntriesPage({super.key, required this.userEmail, required this.currentEntries});

  final String userEmail;

  final currentEntries;

  @override
  State<ViewEntriesPage> createState() => _ViewEntriesPageState();

}

class _ViewEntriesPageState extends State<ViewEntriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Entries History",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.currentEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 110,
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.currentEntries['entry${index + 1}']['date']}',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Text(
                        '${widget.currentEntries['entry${index + 1}']['hours']} hours',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                    Container(
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Text(
                      '${widget.currentEntries['entry${index + 1}']['description']}'
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Divider(
                        height: 20,
                        thickness: 3,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ]
              ),
            )
          );
        },

      ),
    );
  }
}
