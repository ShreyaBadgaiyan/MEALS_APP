import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';

import '../models/category.dart';

class CategoryGridItem extends StatelessWidget{
  const CategoryGridItem({super.key, required this.category, required this.onSelectedCategory});

  final Category category;
  final void Function() onSelectedCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectedCategory,
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [category.color.withOpacity(0.55),
              category.color.withOpacity(0.9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
      
          ),
          borderRadius: BorderRadius.circular(16),

        ),
      
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground
          ),
        ),
      ),
    );
  }
}