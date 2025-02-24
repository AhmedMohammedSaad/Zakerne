import 'package:flutter/material.dart';
import 'package:zakarne/home/home_screen.dart';
import 'package:zakarne/home/true_caller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

//! this is the entry point for the overlay
@pragma("vm:entry-point")
void overlayMain() {
  //! makes sure the widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  //! runs the MaterialApp widget
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      //! sets the home of the app to the TrueCallerOverlay widget
      home: TrueCallerOverlay(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
