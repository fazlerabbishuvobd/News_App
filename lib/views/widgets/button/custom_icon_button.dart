import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.icon,
  });
  final Color color;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 20,
        backgroundColor: color,
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(icon, color: Colors.amber,)
        )
    );
  }
}