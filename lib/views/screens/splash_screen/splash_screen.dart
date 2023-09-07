import 'package:english_news_app/resources/assets/app_icons_name.dart';
import 'package:english_news_app/views/screens/bottom_navbar/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) =>
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavigationBarPage(),))
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.2,
            ),

            _buildAppIcon(),

            const Text('News App',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            ),

            SizedBox(
              height: MediaQuery.sizeOf(context).height*0.05,
            ),

            _buildDevelopedByText(context),
          ],
        ),
      ),
    );
  }

  CircleAvatar _buildAppIcon() {
    return CircleAvatar(
      backgroundColor: Colors.black.withOpacity(0.2),
      radius: 75,
      child: Image.asset(AppIconsName.splashScreenIcon,fit: BoxFit.cover,),
    );
  }

  Column _buildDevelopedByText(BuildContext context) {
    return Column(
      children: [
        const SpinKitCircle(
          color: Colors.amber,
          size: 50.0,
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height*0.05,
        ),

        const Text('Design & Developed By',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
        ),

        const Text('FAZLE RABBI',
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
        ),
      ],
    );
  }
}
