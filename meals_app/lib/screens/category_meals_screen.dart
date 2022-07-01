import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
// import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  // final String categoryID;
  // final String categoryTitle;
  // CategoryMealsScreen(this.categoryID, this.categoryTitle);
  static const routeName = "/category-meals";

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;

  var _loadedInitData = false; // this is the helper to indicate whether we are
  // done with the initialization.

  @override
  void initState() {
    /// ....
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // it runs when the dependencies of the widget changes.
    if (!_loadedInitData) {
      // if did'nt loaded initial data yet then run this code.
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs["title"] as String;
      final categoryId = routeArgs["id"];
      displayedMeals =

          // DUMMY_MEALS.   previously we used dummy_meals as our list.

          widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    // context related work initialized before init state so you can't use it in
    // init state so didChangeDependencies is a perfect solution.
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle as String),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              imageUrl: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
              // removeItem: _removeMeal,
            );
          },
          itemCount: displayedMeals.length,
        )

        // Center(
        //   child: Text("The recipes for the category of id : $categoryId."),
        // ),
        );
  }
}
