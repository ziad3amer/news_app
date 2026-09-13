import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/featuers/auth/repo/auth_reposatery.dart';
import 'package:news_app/featuers/main/main_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  AuthRepository authRepository;

  Future<void> login({required String username, required String password}) async {
    try {
      emit(state.copyWith(status: RequestStatusEnums.loading, errorMessage: null));

      await authRepository.login(username: username, password: password);
    } catch (e) {
      emit(state.copyWith(status: RequestStatusEnums.error, errorMessage: e.toString()));
    }
  }

  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: RequestStatusEnums.loading, errorMessage: null));

    await Future.delayed(Duration(seconds: 3));

    final String? error = await UserRepository().signUp(
      name: name,
      email: email,
      password: password,
    );
    if (error != null) {
      emit(state.copyWith(
        errorMessage: error,
        status: RequestStatusEnums.error,
      ));
      PreferencesMangar().getBoll("is_logged_in") ?? false;

    }
    await PreferencesMangar().setBoll("is_logged_in", true);
    emit(state.copyWith(status: RequestStatusEnums.loaded, errorMessage: null));

  }
}
