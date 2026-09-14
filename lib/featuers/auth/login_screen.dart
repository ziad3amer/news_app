import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/auth/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/featuers/auth/cubit/auth_cubit.dart';
import 'package:news_app/featuers/main/main_screen.dart';

import 'register_screen.dart';
import 'repo/auth_reposatery.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  // String? errorMessage;
  final GlobalKey<FormState> _form = GlobalKey();

  // void login() async {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(AuthApiService())),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (BuildContext context, state) {
            if (state.status == RequestStatusEnums.loading) {
              Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (BuildContext context) {
                return MainScreen();
              },),);
            }

          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png")),
            ),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.all(AppSize.pw16),
                  child: Form(
                    key: _form,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "assets/images/logo.png",
                                height: AppSize.h45,
                              ),
                            ),
                            SizedBox(height: AppSize.ph40),
                            Text(
                              'Welcome to Newts',
                              style: TextStyle(
                                fontSize: AppSize.sp20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: AppSize.ph24),
                            CustomTextFormField(
                              controller: usernameController,
                              hintText: 'ziad@gmail.com',
                              title: 'Email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Email";
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: AppSize.ph24),
                            CustomTextFormField(
                              controller: passwordController,
                              hintText: '*************',
                              title: 'Password',
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Password";
                                }
                                return null;
                              },
                            ),
                            if (state.errorMessage != null)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: AppSize.h8),
                                child: Text(
                                  state.errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            SizedBox(height: AppSize.ph24),
                            ElevatedButton(
                              onPressed: () {
                                if (_form.currentState?.validate() ?? false) {
                                  context.read<AuthCubit>().login(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: state.status==RequestStatusEnums. loading
                                  ? CircularProgressIndicator()
                                  : Text("Sign In"),
                            ),
                            SizedBox(height: AppSize.ph24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don’t have an account ?",
                                  style: TextStyle(fontSize: AppSize.sp14),
                                ),
                                SizedBox(width: AppSize.pw8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return RegisterScreen();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      fontSize: AppSize.sp16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
