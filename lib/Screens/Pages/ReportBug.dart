// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tradeiq/Widgets/SnackBar.dart';
import 'package:tradeiq/constants/colors.dart'; // Adjust the import path

import '../../Services/DatabaseServices.dart'; // Adjust the import path

class BugReportPage extends StatelessWidget {
  final TextEditingController bugDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('Bug Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Please describe the bug:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: bugDescriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter bug details here',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 18),
                padding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                    color: Color.fromARGB(255, 33, 166, 243),
                  ),
                ),
              ),
              onPressed: () async {
                String bugDescription = bugDescriptionController.text;
                String res =
                    await DatabaseServices().addBugReport(bugDescription);

                if (res == 'Success') {
                  bugDescriptionController.clear();
                  showSnackBarSuccess(
                    'Bug Submitted',
                    'Thank you for reporting the bug',
                    context,
                  );
                } else {
                  showSnackBarfail(
                    'Some error...',
                    'Try again',
                    context,
                  );
                }
              },
              child: const Text(
                'Submit Bug Report',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
