import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/api_config.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/models/user_model.dart';

class AuthRepository {
  AuthRepository(this.apiService);

  final ApiService apiService;

  Future<UserModel?> login({required String username, required String password}) async {
   final response =
   await apiService.Post(
      ApiConfig.login,
      ApiConfig.authBaseUrl,
      body: {
        "username": username,
        "password": password,
        "expiresIn": 30,
      },
    );
   UserModel model = UserModel.fromAuthResponseJson(response, username);
   await _saveUser(model);
   return model;
  }
  Future _saveUser(UserModel model) async{
    await   UserRepository().saveUser(model);

  }
}
