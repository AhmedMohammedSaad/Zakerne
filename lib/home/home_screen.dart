import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  //! Method to request overlay window permissions
  void _requestPermissions() async {
    bool isGranted = await FlutterOverlayWindow.isPermissionGranted();
    if (!isGranted) {
      await FlutterOverlayWindow.requestPermission();
    }
  }

  final TextEditingController _controller = TextEditingController();
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //! AppBar with a centered title
        title: const Text('بسم الله'),
        centerTitle: true,
      ),
      body: Center(
        //! Centered column containing input field and buttons
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                //! Input field for entering time in seconds
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "اضف الوقت بالثواني",
                  hintStyle: const TextStyle(fontSize: 20),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            TextButton(
              //! Button to start the overlay
              onPressed: _startOverlay,
              child: const Text(
                "بدء",
                style: TextStyle(fontSize: 30),
              ),
            ),
            TextButton(
              //! Button to stop the overlay and cancel the timer
              onPressed: () {
                FlutterOverlayWindow.closeOverlay();
                _timer!.cancel();
              },
              child: const Text(
                "إيقاف",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //! Method to start the overlay with a timer based on user input
  void _startOverlay() {
    final int? seconds = int.tryParse(_controller.text);
    if (seconds == null || seconds <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("رجاء إدخال وقت صحيح")),
      );
      return;
    }

    _timer?.cancel(); //! Cancel the previous timer if it exists
    _timer = Timer.periodic(Duration(seconds: seconds), (timer) async {
      if (await FlutterOverlayWindow.isActive()) return;
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "بسم الله",
        flag: OverlayFlag.defaultFlag,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.auto,
        // ignore: use_build_context_synchronously
        height: (MediaQuery.of(context).size.height * 0.6).toInt(),
        width: WindowSize.matchParent,
        startPosition: const OverlayPosition(0, -259),
      );
    });
  }

  @override
  void dispose() {
    //! Dispose of controllers and timers
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
