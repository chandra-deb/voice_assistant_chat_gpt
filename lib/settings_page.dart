import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/settings_provider.dart';

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
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Theme'),
            trailing: Switch(
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
        ],
      ),
    );
  }
}
