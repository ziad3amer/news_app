import 'package:flutter/cupertino.dart';

class OnboardingController with ChangeNotifier{
  PageController pageController = PageController();
   int currentIndex = 0;
   bool isLastPage = false;

   void onPageChange(int index){
     currentIndex=index;
     if(index ==2){
       isLastPage=true;
     }
     else{
       isLastPage=false;
     }
     notifyListeners();
   }

}