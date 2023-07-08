import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
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

class ThemeSelection with ChangeNotifier {
  ThemeData _selectedTheme = lightTheme;

  ThemeSelection() {
    // Listen to changes in system brightness
    window.onPlatformBrightnessChanged = () {
      final Brightness brightness = window.platformBrightness;
      // Update the selected theme based on system brightness
      if (brightness == Brightness.dark) {
        _selectedTheme = darkTheme;
      } else {
        _selectedTheme = lightTheme;
      }
      notifyListeners();
    };
  }

  ThemeData get selectedTheme => _selectedTheme;
  void setTheme(ThemeData themeData) {
    _selectedTheme = themeData;
    notifyListeners();
  }
}

class ThemeSelection1 extends ChangeNotifier {
  ThemeData _selectedTheme = lightTheme;

  ThemeData get selectedTheme => _selectedTheme;
}

class ThemesPage extends StatelessWidget {
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
