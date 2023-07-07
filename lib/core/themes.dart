import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  // Define other theme properties as per your requirement
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 39, 37, 42),
  // Define other theme properties as per your requirement
);

final customTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.redAccent,
  // Define other theme properties as per your requirement
);

class ThemeSelection extends ChangeNotifier {
  ThemeData _selectedTheme = lightTheme;

  ThemeData get selectedTheme => _selectedTheme;

  void setTheme(ThemeData themeData) {
    _selectedTheme = themeData;
    notifyListeners();
  }
}

class ThemesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeSelection>(
      builder: (context, themeSelection, child) {
        return MaterialApp(
          title: 'Theme Selection Demo',
          theme: themeSelection.selectedTheme,
          home: SettingsScreen(),
        );
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeSelection = Provider.of<ThemeSelection>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Light Theme'),
            onTap: () {
              themeSelection.setTheme(lightTheme);
            },
          ),
          ListTile(
            title: Text('Dark Theme'),
            onTap: () {
              themeSelection.setTheme(darkTheme);
            },
          ),
          ListTile(
            title: Text('Custom Theme'),
            onTap: () {
              themeSelection.setTheme(customTheme);
            },
          ),
        ],
      ),
    );
  }
}
