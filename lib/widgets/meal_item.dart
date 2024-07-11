import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText{
    return meal.complexity.name[0].toUpperCase()+meal.complexity.name.substring(1);
    //converting string like title where first letter is captical
  }

  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase()+meal.affordability.name.substring(1);
    //converting string like title where first letter is captical
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      clipBehavior: Clip.hardEdge,
      //this removes any content of child widget that would go out of the border, helping to get perfect borders.
      elevation: 2,
      //gives 3d effect
      child: InkWell(
        onTap: (){
          onSelectMeal(meal);
        },
        //Stack is used to place widgets directly above each other.

        child: Stack(
          children: [
            //adds faded image
            FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),

            Positioned(
              bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 44),
                  color: Colors.black54 ,
                  child: Column(
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        //if title is bigger then dots ....
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min'),
                          const SizedBox(width: 12,),
                          MealItemTrait(icon: Icons.work, label:complexityText),
                          const SizedBox(width: 12,),
                          MealItemTrait(icon: Icons.attach_money, label: affordabilityText
                          ),
                          const SizedBox(width: 12,),



                        ],
                      )
                    ],
                    
                  ),

                ))
          ],
        ),
      ),
    );
  }
}



