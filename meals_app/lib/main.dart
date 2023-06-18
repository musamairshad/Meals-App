import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';
import 'screens/category_meals_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"] == true && !meal.isVegan) {
          return false;
        }
        if (_filters["vegetarian"] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealID) {
    final existingIndex = _favouriteMeals.indexWhere((meal) {
      return meal.id == mealID;
    });
    if (existingIndex >= 0) {
      _favouriteMeals.removeAt(existingIndex);
    } else {
      setState(() {
        // we use dummy meals because we want that the filtering does'nt work
        // here.
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) {
          // first where is used to find the first element based on
          // the condition you specify in the function.
          return meal.id == mealID;
        }));
      });
    }
    ;
    // if the meal is not part of favouriteMeals
    // then the index is -1 otherwise index is >= 0
  }

  bool _isMealFavourite(String id) {
    return _favouriteMeals.any((meal) {
      // any runs on every item of the list and it stops when it returns
      // true for the first time.
      return meal.id == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DeliMeals",
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              // titleLarge: TextStyle(
              //   fontSize: 24,
              //   fontFamily: "RobotoCondensed",
              // ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      // home: CategoriesScreen(),
      initialRoute: "/", // default route is "/".
      routes: {
        "/": (context) => TabsScreen(_favouriteMeals),
        // "/": (context) => CategoriesScreen(),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (context) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // // load this route for any route which is not registerd.
        // if(settings.name == "/"){
        //   return ... // particular widget.
        // } else if(settings.name == "/something-else"){
        //   return ... // something else.
        // }
        // print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        // it reaches when flutter failed to build screen then this unknown route
        // reaches. this is like 404 error page.
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
