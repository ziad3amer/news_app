import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'onpording_state.dart';

class OnpordingCubit extends Cubit<OnbordindState> {
  OnpordingCubit() : super(OnbordindState());

  final PageController pageController = PageController();

  void onPageChange(int index){
    if(index ==2){
      emit(state.copyWith(
          isLastPage:true,
        currentIndex: index
      ));

    }
    else{
      emit(state.copyWith(
        isLastPage:false,
        currentIndex: index
      ));

    }

  }


}
