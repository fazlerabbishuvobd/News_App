import 'package:flutter/material.dart';

class CustomListTileWidgets extends StatelessWidget {
  const CustomListTileWidgets({
    super.key,
    required this.icon,
    required this.name,
    required this.icon2,
    this.onPressed,
  });

  final IconData icon;
  final String name;
  final IconData icon2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ListTile(
        leading: Icon(icon,size: 36,),
        title: Text(name),
        trailing: Icon(icon2),
      ),
    );
  }
}