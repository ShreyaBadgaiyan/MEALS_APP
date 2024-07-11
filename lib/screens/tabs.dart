import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex=0;
  final List<Meal> _favoriteMeal=[];
  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  void _toggleMealFavoritesStatus(Meal meal){
    final isExisting=_favoriteMeal.contains(meal);
    if(isExisting){
      setState(() {
        _favoriteMeal.remove(meal);
        _showInfoMessage('Meal is no longer a favorite');

      });
    }else{
      setState(() {
        _favoriteMeal.add(meal);
_showInfoMessage('Meal is marked as favorite');
      });
    }
  }

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex=index;
    });
  }

  void _setScreen(String identifier){
if(identifier=='filters'){

}else{
  Navigator.of(context).pop();
  //Closing the drawer when meals is clicked coz we have to open the tab itself
}
  }


  @override
  Widget build(BuildContext context) {
    Widget activePage=CategoriesScreen(onToggleFavorite:_toggleMealFavoritesStatus,);
    var activePageTitle='Categories';
    if(_selectedPageIndex==1){
      activePage=MealsScreen(
          meals: _favoriteMeal, onToggleFavorite: _toggleMealFavoritesStatus,);
      activePageTitle='Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer:  MainDrawer(onSelectScreen:_setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        //highlights pages as per which were on screen
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label:"Categories" ),
          BottomNavigationBarItem(icon:Icon(Icons.star) ,label:"Favorites" )
        ],
      ),
    );
  }
}
