import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;
  FavoritesScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favourites yet - start adding some!",style: Theme.of(context).textTheme.titleMedium,),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
            // removeItem: _removeMeal,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }
  }
}
