import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 39, 37, 42),
);

final customTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.redAccent,
);

class ThemeSelection with ChangeNotifier {
  ThemeData _selectedTheme = lightTheme;

  ThemeSelection() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    if (brightness == Brightness.dark) {
      _selectedTheme = darkTheme;
    } else {
      _selectedTheme = lightTheme;
    }
  }

  ThemeData get selectedTheme => _selectedTheme;

  void setTheme(ThemeData themeData) {
    _selectedTheme = themeData;
    notifyListeners();
  }
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
