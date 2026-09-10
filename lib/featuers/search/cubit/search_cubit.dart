import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/repos/new_repository.dart';
import 'package:news_app/featuers/home/models/news_articles_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRpository) : super(SearchState());

  TextEditingController searchController = TextEditingController();
  final BaseNewsRpository newsRpository;

  getTopEverything() async {
    try {
      emit(
        state.copyWith(
          newsEverythingList: await newsRpository.getTopEverything(
            query: searchController.text,
          ),
          everythingStatus: RequestStatusEnums.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          everythingStatus: RequestStatusEnums.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
