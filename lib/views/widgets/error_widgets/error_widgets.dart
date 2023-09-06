import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/views/widgets/button/custom_material_button.dart';
import 'package:flutter/material.dart';

class ErrorWidgets extends StatelessWidget {
  const ErrorWidgets({super.key,this.widgetHeight, required this.onPressed});
  final double? widgetHeight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: widgetHeight,
          width: MediaQuery.sizeOf(context).width,
          child: Image.asset(AppImageName.errorImage),
        ),
        Positioned(
          bottom: 0,
          child: CustomMaterialButton(
            color: Colors.amber,
            onPressed: onPressed,
            icon: Icons.refresh,
            title: "Retry",
            buttonHeight: height*0.06,
            buttonWidth: width*0.4,
            buttonIsLoading: true,
          ),
        )
      ],
    );
  }
}