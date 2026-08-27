import 'package:flutter/material.dart';
import 'package:news_app/featuers/bookmark/bookmark_screen.dart';
import 'package:news_app/featuers/bookmark/data/bookmark_repository.dart';
import 'package:news_app/featuers/home/home_screen.dart';
import 'package:news_app/featuers/profile/profile_screen.dart';
import 'package:news_app/featuers/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _bookmarksCount = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _updateBookmarksCount();
  }

  void _updateBookmarksCount() {
    setState(() {
      _bookmarksCount = BookmarkRepository().bookMarkCount();
    });
  }

  Widget _buildBookmarkIcon() {
    if (_bookmarksCount == 0) {
      return const Icon(Icons.bookmark_border);
    }
    return Badge(
      label: Text(_bookmarksCount.toString(),),
      child: const Icon(Icons.bookmark_border),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
          if(_currentIndex==2){
            _updateBookmarksCount();
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
