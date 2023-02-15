import 'package:flutter/material.dart';

void showPopup(
  BuildContext context, {
  required Widget child,
  required String buttonName,
  required Function onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: SizedBox(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                  'You have to give microphone permission to use voice recognition feature.'),
              Text('To enable this:'),
              Text(
                'Click The App Settings button',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Then go to Permissions and allow microphone permission',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            onPressed: () => onPressed(),
            child: Text(buttonName),
          ),
        ],
      );
    },
  );
}
