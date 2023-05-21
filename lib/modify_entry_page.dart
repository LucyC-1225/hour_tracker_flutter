import 'package:flutter/material.dart';

class ModifyEntriesPage extends StatefulWidget {
  const ModifyEntriesPage({Key? key}) : super(key: key);

  @override
  State<ModifyEntriesPage> createState() => _ModifyEntriesPageState();
}

class _ModifyEntriesPageState extends State<ModifyEntriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Modify/Delete Entries",
          style: TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );;
  }
}
