import 'package:flutter/material.dart';
import 'package:miruvor/features/cellar/presentation/add_wine_page.dart';
import 'package:miruvor/features/cellar/presentation/cellar_page.dart';
import 'package:miruvor/features/home/presentation/home_page.dart';
import 'package:miruvor/features/price_check/presentation/price_check_page.dart';
import 'package:miruvor/features/tasting_notes/presentation/tasting_notes_page.dart';
import 'package:miruvor/features/wine_search/presentation/wine_search_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  static const _titles = [
    'Miruvor',
    'My Cellar',
    'Tasting Notes',
    'Price Check',
    'Wine Search',
  ];

  static const _pages = [
    HomePage(),
    CellarPage(),
    TastingNotesPage(),
    PriceCheckPage(),
    WineSearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        actions: [
          IconButton(
            tooltip: '와인 추가',
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const AddWinePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.wine_bar_outlined),
            selectedIcon: Icon(Icons.wine_bar),
            label: 'Cellar',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon: Icon(Icons.edit_note),
            label: 'Notes',
          ),
          NavigationDestination(
            icon: Icon(Icons.price_check_outlined),
            selectedIcon: Icon(Icons.price_check),
            label: 'Prices',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
