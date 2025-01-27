import 'package:flutter/material.dart';

class HoverableButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? hoverColor;
  final Color? pressColor;
  final Color? iconColor;
  final double size;

  const HoverableButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.hoverColor,
    this.pressColor,
    this.iconColor,
    this.size = 24.0,
  }) : super(key: key);

  @override
  _HoverableButtonState createState() => _HoverableButtonState();
}

class _HoverableButtonState extends State<HoverableButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onPressed(); // Trigger callback
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isPressed
                ? widget.pressColor ?? Colors.grey[300]
                : _isHovered
                    ? widget.hoverColor ?? Colors.grey[200]
                    : Colors.transparent,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(8),
          child: Icon(
            widget.icon,
            size: widget.size,
            color: widget.iconColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
