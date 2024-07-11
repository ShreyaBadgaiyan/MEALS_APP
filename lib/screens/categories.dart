import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  
  void _selectCategory(BuildContext context, category){
    final filteredMeals=dummyMeals.where((meal)=>meal.categories.contains(category.id)).toList();

    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MealsScreen(title: category.title, meals:filteredMeals)));
        //as it is not case of stateful widget therefore, we need to pass context as buildContext here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        padding: EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10
          ),
        //No. of columns we can have
        children: [
          for(final category in availableCategories)
            CategoryGridItem(category: category, onSelectedCategory: () {
              _selectCategory(context,category);
            },)
        ],
      ),
    );
  }
}

