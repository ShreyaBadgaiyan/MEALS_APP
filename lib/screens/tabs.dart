import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';

const kInitialFilters={
  Filter.glutenFree:false,
  Filter.lactoseFree:false,
  Filter.vegan:false,
  Filter.vegetarian:false,
};
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex=0;
  final List<Meal> _favoriteMeal=[];

  Map<Filter,bool> _selectedFilters=kInitialFilters;
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

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();

    if(identifier=='filters'){
  final result=await Navigator.of(context).push<Map<Filter,bool>>
    (MaterialPageRoute(builder: (ctx)=>FiltersScreen(currentFilters: _selectedFilters ,)));
  setState(() {
    _selectedFilters=result??kInitialFilters;

  });

}
  }



  @override
  Widget build(BuildContext context) {

    final availableMeals=dummyMeals.where((meal){
      if(_selectedFilters[Filter.glutenFree]!&&!meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]!&&!meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]!&&!meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]!&&!meal.isVegan){
        return false;
      }
      return true;

    }).toList();
    Widget activePage=CategoriesScreen(onToggleFavorite:_toggleMealFavoritesStatus, availableMeals: availableMeals,);
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
