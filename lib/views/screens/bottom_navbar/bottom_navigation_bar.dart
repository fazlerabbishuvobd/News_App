import 'package:english_news_app/views/screens/bookmark_page/bookmark_page_view.dart';
import 'package:english_news_app/views/screens/homePage/home_page_view.dart';
import 'package:english_news_app/views/screens/homePage/news_details_view.dart';
import 'package:english_news_app/views/screens/profile_page/profile_page_view.dart';
import 'package:english_news_app/views/screens/search_page/search_page_view.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int _currentIndex = 0;
  List pages = [
    const HomePageView(),
    const BookmarkPageView(),
    const SearchPageView(),
    const ProfilePageView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      extendBody: true,
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
            unselectedColor: Colors.amber,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.bookmark),
            title: const Text("Bookmark"),
            selectedColor: Colors.pink,
            unselectedColor: Colors.amber,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.orange,
            unselectedColor: Colors.amber,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
            unselectedColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
