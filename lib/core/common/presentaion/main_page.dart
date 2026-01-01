import 'package:cineflow/features/auth/presentation/pages/profile_page.dart';
import 'package:cineflow/features/movie/presentation/pages/movie_search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final _movieKey = GlobalKey<MovieSearchPageState>();
  late List<Widget> widgets;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widgets = [MovieSearchPage(key: _movieKey), const ProfilePage()];
  }

  void _onItemTapped(int index) {
    if (_currentIndex == index && index == 0) {
      _movieKey.currentState?.scrollToTop();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: widgets),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
