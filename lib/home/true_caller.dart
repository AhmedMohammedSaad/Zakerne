import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class TrueCallerOverlay extends StatefulWidget {
  const TrueCallerOverlay({super.key});

  @override
  State<TrueCallerOverlay> createState() => _TrueCallerOverlayState();
}

class _TrueCallerOverlayState extends State<TrueCallerOverlay> {
  //! This list defines a gradient with gold-like colors for styling purposes
  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      //! Make the background transparent
      color: Colors.transparent,
      //! The child of the material is aligned to the center of the screen
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _goldColors,
            ),
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // ! not MainAxisSize.max

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //! It is used to align the close button to the right of the column
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () async {
                    await FlutterOverlayWindow.closeOverlay();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),

              const Divider(color: Colors.black54),

              //! It is used to display the message
              Text(
                "بسم الله الرحمن الرحيم",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
