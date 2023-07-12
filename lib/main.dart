import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_method_flutter/core/themes.dart';
import 'package:rest_method_flutter/view/groupview.dart';
import 'package:rest_method_flutter/view/homeview.dart';
import 'package:rest_method_flutter/viewmodel/faultmessageViewModel.dart';
import 'package:rest_method_flutter/viewmodel/groupviewmodel.dart';
import 'package:rest_method_flutter/viewmodel/onoffviewmodel.dart';
import 'package:rest_method_flutter/viewmodel/send_receiveviewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GroupViewModel>(
          create: (_) => GroupViewModel(),
        ),
        ChangeNotifierProvider<SendReceiveViewModel>(
          create: (_) => SendReceiveViewModel(),
        ),
        ChangeNotifierProvider<ThemeSelection>(
          create: (_) => ThemeSelection(),
        ),
        ChangeNotifierProvider<onoffViewModel>(create: (_) => onoffViewModel()),
        ChangeNotifierProvider<FaultmessageViewModel>(
          create: (context) => FaultmessageViewModel(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<GroupViewModel>(context, listen: true);
    final themeSelection = Provider.of<ThemeSelection>(context, listen: true);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: themeSelection.selectedTheme,
        debugShowCheckedModeBanner: false,
        home: Homepage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
