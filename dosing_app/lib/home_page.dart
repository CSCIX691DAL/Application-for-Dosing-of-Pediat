import 'package:flutter/material.dart';
import 'all_page.dart';
import 'favs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Widget> _screens = [AllPage(), FavouritesPage()];

  // Changing the state of the bottom nav bar
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update state of the app
                // ...
                // Then close drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
              Icons.star,
              color: _selectedIndex == 1 ? Colors.indigo : Colors.grey,
            ),
            label: 'Favourites',
          ),
        ],
        currentIndex: _selectedIndex,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
