import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';
import 'utils/popup_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            settings.appTheme == AppTheme.dark ? Colors.black : Colors.pink,
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.surround_sound),
            title: const Text('Auto Read Message'),
            trailing: Switch(
              activeColor: Colors.pink,
              value: settings.isAutoReadAloud,
              onChanged: (value) async {
                if (value == true) {
                  settings.setAutoRead(true);
                } else {
                  settings.setAutoRead(false);
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Theme'),
            trailing: Switch(
              activeColor: Colors.pink,
              value: settings.appTheme == AppTheme.dark,
              onChanged: (value) {
                if (value == true) {
                  settings.setAppTheme(AppTheme.dark);
                } else {
                  settings.setAppTheme(AppTheme.light);
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              showPopup(
                context,
                child: const Text('Do you want to delete your conversation?'),
                buttonName: 'Delete',
                onPressed: () async {
                  await settings.deleteConversation();
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: SizedBox(
                        height: 40,
                        child: Text(
                          'Deleted!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
              );
            },
            child: const ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              title: Text(
                'Delete Conversation',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
