import 'package:flutter/material.dart';
import 'package:weather_application/view/home_screen.dart';
import 'package:weather_application/view/search_screen.dart';

class Navigation extends ChangeNotifier{
   int currentPageIndex=0;
   List<Widget> pageList=[HomePage(),SearchPage()];
   void changeNav(int index){

    currentPageIndex=index;
    notifyListeners();
   }
}