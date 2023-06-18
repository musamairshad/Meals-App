import 'package:flutter/material.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabsScreen(this.favouriteMeals);
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;

  int _selectedPageIndex = 0;

  @override
  void initState() {
    // initState runs before build runs.
    _pages = [
      {"page": CategoriesScreen(), "title": "Categories"},
      {
        "page": FavoritesScreen(widget.favouriteMeals), "title": "Favorites",
        // "Actions" : {}, you can add widgets here also.
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

// you can use widget property in the build method or initState but you
// can't use it when initializing your properties.
  @override
  Widget build(BuildContext context) {
    return
        // DefaultTabController(
        //   length: 2,
        //   initialIndex: 0,
        //   child:
        Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["title"]),
        // bottom: TabBar(
        //   tabs: [
        //   Tab(
        //     icon: Icon(Icons.category),
        //     child: Text("Categories"),
        //   ),
        //   Tab(
        //     icon: Icon(Icons.star),
        //     child: Text("Favorites"),
        //   ),
        // ],
        // ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        // type: BottomNavigationBarType.fixed, // default.
        items: [
          BottomNavigationBarItem(
              // backgroundColor: Theme.of(context).primaryColor,
              label: "Categories",
              icon: Icon(
                Icons.category,
              )),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(
              Icons.star,
            ),
          ),
        ],
      ),
      // TabBarView(children: [
      //   CategoriesScreen(),
      //   FavoritesScreen(),
      // ],
      // ),
    );
  }
}
