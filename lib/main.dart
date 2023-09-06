import 'package:english_news_app/viewmodel/theme_view_model.dart';
import 'package:english_news_app/views/screens/bottom_navbar/bottom_navigation_bar.dart';
import 'package:english_news_app/views/screens/search_page/search_page_view.dart';
import 'package:english_news_app/views/widgets/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  final themeController = Get.put(ThemeViewModel());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: themeController.themeMode.value,
        home: const BottomNavigationBarPage(),
      );
    });
  }
}