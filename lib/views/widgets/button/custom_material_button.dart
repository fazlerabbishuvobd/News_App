import 'package:flutter/material.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.color,
    required this.onPressed,
    required this.icon,
    required this.title,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.buttonIsLoading,
  });

  final Color color;
  final VoidCallback onPressed;
  final IconData icon;
  final String title;
  final double buttonHeight,buttonWidth;
  final bool buttonIsLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: MaterialButton(
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: buttonHeight,
          width: buttonWidth,
          child: buttonIsLoading?
          const Center(child: CircularProgressIndicator()):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              const SizedBox(width: 10,),
              Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}