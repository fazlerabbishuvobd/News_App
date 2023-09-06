import 'package:english_news_app/resources/assets/app_image_name.dart';
import 'package:english_news_app/views/widgets/profile_page/custom_list_tile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text('Account',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                SizedBox(height: height*0.015,),

                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Image.asset(AppImageName.noImage),
                      ),
                      SizedBox(width: width*0.03,),
                      const Text('Fazle Rabbi'),
                      const Text('frs.cse@gmail.com')
                    ],
                  ),
                ),
                SizedBox(height: height*0.03,),

                const Divider(),
                const CustomListTileWidgets(icon: Icons.dark_mode,name: 'Dark Mode',icon2: Icons.toggle_off_sharp,),
                const Divider(),
                const CustomListTileWidgets(icon: Icons.g_translate,name: 'Change Language',icon2: Icons.arrow_forward_ios_outlined,),
                const Divider(),
                const CustomListTileWidgets(icon: Icons.policy,name: 'Privacy Policy',icon2: Icons.arrow_forward_ios_outlined,),
                const Divider(),
                CustomListTileWidgets(
                  icon: Icons.description_rounded,
                  name: 'About Me',
                  icon2: Icons.arrow_forward_ios_outlined,
                  onPressed: () {
                    buildContactMeBottomSheet(height, width);
                  },
                ),
                const Divider(),
                CustomListTileWidgets(
                  icon: Icons.contact_page,
                  name: 'Contact Me',
                  icon2: Icons.arrow_forward_ios_outlined,
                  onPressed: () {
                    buildContactMeBottomSheet(height, width);
                  },
                ),
                const Divider(),
                const CustomListTileWidgets(icon: Icons.logout,name: 'Logout',icon2: Icons.arrow_forward_ios_outlined,),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildContactMeBottomSheet(double height, double width) {
    return Get.bottomSheet(
      Container(
        height: height*0.3,
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              height: height*0.01,
              width: width*0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
            ),
            CircleAvatar(
              radius: 50,
              child: Image.asset(AppImageName.noImage),
            ),
            const Text("Fazle Rabbi"),
            const Text("frs.cse@gmail.com"),
            const Text("01767 364544"),
            const Text("Mohammadpur,Dhaka-1207"),
          ],
        ),
      ),
    );
  }

}

