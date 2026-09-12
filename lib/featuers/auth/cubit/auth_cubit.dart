import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart' show Equatable;
import 'package:meta/meta.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/featuers/auth/repo/auth_reposatery.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());

  AuthRepository authRepository ;

  Future<void>login({required String username, required String password})async {
    try{
      emit(state.copyWith(status: RequestStatusEnums.loading,errorMessage: null));

      await authRepository.login(username: username, password: password);
    }catch(e){
      emit(state.copyWith(status: RequestStatusEnums.error,errorMessage: e.toString()));
    }

  }
}
