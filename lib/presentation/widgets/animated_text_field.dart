import 'package:flutter/material.dart';

class AnimatedTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final int delay;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const AnimatedTextField({
    super.key, 
    required this.label, 
    this.obscureText = false, 
    this.delay = 0,
    this.controller,
    this.validator,
  });

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600), 
      vsync: this
    );
    _animation = CurvedAnimation(
      parent: _controller, 
      curve: Curves.easeOut
    );
    Future.delayed(Duration(milliseconds: widget.delay), () { 
      if (mounted) _controller.forward(); 
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation.drive(
        Tween(begin: const Offset(-0.5, 0), end: Offset.zero)
      ),
      child: FadeTransition(
        opacity: _animation,
        child: TextField(
          controller: widget.controller,
          obscureText: widget.obscureText,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(color: Colors.grey[600]),
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), 
              borderSide: BorderSide.none
            ),
          ),
        ),
      ),
    );
  }
}