import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showSnackBar(
      BuildContext context,
      String message, {
        Duration duration = const Duration(seconds: 3),
        double speedMultiplier = 1.1, // Parameter to control the speed
      }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20), // same as button container
            child: _AnimatedSnackBar(
                message: message, speedMultiplier: speedMultiplier),
          ),
        );
      },
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration + const Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }
}

class _AnimatedSnackBar extends StatefulWidget {
  final String message;
  final double speedMultiplier; // Speed control

  const _AnimatedSnackBar(
      {required this.message, required this.speedMultiplier});

  @override
  State<_AnimatedSnackBar> createState() => _AnimatedSnackBarState();
}

class _AnimatedSnackBarState extends State<_AnimatedSnackBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Adjust the duration based on the speed multiplier
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (400 / widget.speedMultiplier).round()),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xff008B8B),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Text(
            widget.message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}