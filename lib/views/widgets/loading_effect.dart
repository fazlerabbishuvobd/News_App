import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class LoadingEffectWidgets {
  Widget loadingEffectWidgets(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildEffect(context),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
            _buildEffect(context),
            SizedBox(height: MediaQuery.sizeOf(context).height*0.02),
            _buildContainerEffect(MediaQuery.sizeOf(context).height*0.06, MediaQuery.sizeOf(context).width)
          ],
        ),
      ),
    );
  }
  Widget _buildEffect(BuildContext context) {

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContainerEffect(height*0.12, width*0.17),
        SizedBox(
          width: width*0.02,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContainerEffect(height*0.08, width),
              SizedBox(
                height: height*0.01,
              ),
              
              Row(
                children: [
                  _buildContainerEffect(height*0.03, width * 0.35),
                  SizedBox(
                    width: width*0.01,
                  ),
                  _buildContainerEffect(height*0.03, width * 0.35),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _buildContainerEffect(double height, double width) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      );
  }


  Widget imageLoadingEffectWidgets(BuildContext context){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildContainerEffect(
            MediaQuery.sizeOf(context).height*0.06,
            MediaQuery.sizeOf(context).width*0.06),
      ),
    );
  }
  Widget breakingNewsLoadingEffectWidgets(BuildContext context){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildContainerEffect(
            MediaQuery.sizeOf(context).height*0.16,
            MediaQuery.sizeOf(context).width*0.9
        ),
      ),
    );
  }

}


