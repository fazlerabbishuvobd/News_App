import 'package:flutter/material.dart';

class NoMoreNewsWarningWidgets extends StatelessWidget {
  const NoMoreNewsWarningWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        height: 48,
        child: const Text("No More available",style: TextStyle(fontWeight: FontWeight.bold),)
    );
  }
}