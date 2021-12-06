import 'package:flutter/material.dart';
import 'all_page.dart';
import 'favs_page.dart';

class HomePage extends StatefulWidget {
  // was const
  HomePage({Key? key, required this.medications, required this.favMedications})
      : super(key: key);
  dynamic medications;
  dynamic favMedications;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();

  // Changing the state of the bottom nav bar
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Change page when navbar is tapped
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      AllPage(
        medications: widget.medications,
        favMedications: widget.favMedications,
      ),
      FavouritesPage(
        medications: widget.medications,
        favMedications: widget.favMedications,
      ),
    ];
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books,
              color: _selectedIndex == 0 ? Colors.indigo : Colors.grey,
            ),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark,
              color: _selectedIndex == 1 ? Colors.indigo : Colors.grey,
            ),
            label: 'Favourites',
          ),
        ],
        currentIndex: _selectedIndex,
      ),
    );
  }
}
