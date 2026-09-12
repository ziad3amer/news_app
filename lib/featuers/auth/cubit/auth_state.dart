part of 'auth_cubit.dart';

@immutable
 class AuthState extends Equatable  {
  @override
  List<Object?> get props => [
    status,
    userModel,
    errorMessage,
  ];

  final RequestStatusEnums status;
  final UserModel? userModel;
  final String? errorMessage;

  const AuthState({
    this.status = RequestStatusEnums.loading,
    this.userModel,
    this.errorMessage,
  });

  AuthState copyWith({
    RequestStatusEnums? status,
    UserModel? userModel,
    String? errorMessage,
}){
    return AuthState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      errorMessage: errorMessage  ,
    );
  }



}

