import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/repos/new_repository.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newRepository) : super(HomeInitial()){
    getTopHeadline();
    getTopEverything();
  }
  final BaseNewsRpository newRepository;

  getTopHeadline({String? category}) async {
    try {
      emit(state.copyWith(
        newsTopHeadlineStates: RequestStatusEnums.loading,
      ));

      final articles = await newRepository.getTopHeadline(selectedCategory:state. selectedCategory);
     emit(state.copyWith(
       newsTopHeadlineList: articles,
       newsTopHeadlineStates: RequestStatusEnums.loaded,
       errorMessage: null,
     ));

    } catch (e) {
      emit(state.copyWith(
          newsTopHeadlineStates : RequestStatusEnums.error,
          errorMessage: e.toString(),
      ));
    }
  }

  getTopEverything({String? category}) async {
    try {
      final articles = await newRepository.getTopEverything();
    emit(state.copyWith(
      newsEverythingList: articles,
      everythingStatus: RequestStatusEnums.loaded,
      errorMessage: null,
    ));

    } catch (e) {
      emit(state.copyWith(
          everythingStatus: RequestStatusEnums.error,
          errorMessage : e.toString(),
      ));
    }
  }

  void updateSelectedCategory(String category) {
    emit(state.copyWith(
        selectedCategory : category,


    ));
  }
}
