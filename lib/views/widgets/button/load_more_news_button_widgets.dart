import 'package:flutter/material.dart';
class LoadMoreNewsButton extends StatelessWidget {
  const LoadMoreNewsButton({super.key,required this.onPressed, required this.buttonIsLoading,});

  final VoidCallback onPressed;
  final bool buttonIsLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 48,
          child: buttonIsLoading?
          const Center(child: CircularProgressIndicator()):
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Load More'),
              SizedBox(width: 10,),
              Icon(Icons.cloud_download),
            ],
          ),
        ),
      ),
    );
  }
}
