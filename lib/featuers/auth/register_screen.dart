import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocListener, BlocBuilder, ReadContext;
import 'package:http/http.dart' show read;
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/auth/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/featuers/auth/cubit/auth_cubit.dart';
import 'package:news_app/featuers/main/main_screen.dart';

import 'repo/auth_reposatery.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  GlobalKey<FormState> _FormKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  // void register() async {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (BuildContext context) => AuthCubit(AuthRepository(AuthApiService())),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state.status == RequestStatusEnums.loading) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MainScreen();
                  },
                ),
              );
            }

          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background.png")),
            ),
            child: Padding(
              padding: EdgeInsets.all(AppSize.pw16),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  return Form(
                    key: _FormKey,
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
                            SizedBox(height: 40),
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
                              hintText: 'Ziad Amer',
                              title: 'username',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Password";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: AppSize.ph24),
                            CustomTextFormField(
                              controller: emailController,
                              hintText: 'ziad@gmail.com',
                              title: 'Email',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter your Email";
                                }
                                RegExp emailRegExp = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                );
                                if (!emailRegExp.hasMatch(value)) {
                                  return "Please Enter Valid Email";
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
                            SizedBox(height: AppSize.ph24),
                            CustomTextFormField(
                              controller: confirmPasswordController,
                              hintText: '*************',
                              title: 'Confirm Password',
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
                                padding: EdgeInsets.symmetric(vertical: AppSize.h8),
                                child: Text(
                                  state.errorMessage!,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            SizedBox(height: AppSize.ph24),
                            ElevatedButton(
                              onPressed: () {
                                if (_FormKey.currentState?.validate() ?? false) {
                                 context.read<AuthCubit>().register(name: usernameController.text, email:emailController.text, password: passwordController.text);
                                }
                              },
                              child:
                             state.status==RequestStatusEnums.loading
                                  ? CircularProgressIndicator()
                                  : Text("Sign Up"),
                            ),
                            SizedBox(height: AppSize.ph24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Have an account ?",
                                  style: TextStyle(fontSize: AppSize.sp14),
                                ),
                                SizedBox(width: AppSize.pw8),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },

                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
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
                  );
                },

              ),
            ),
          ),
        ),
      ),
    );
  }
}
