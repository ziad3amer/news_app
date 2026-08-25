import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/featuers/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _FormKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();

  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));

    final String? error = await UserRepository().signUp(
      name: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
    }
      await PreferencesMangar().setBoll("is_logged_in", true);
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
  }

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/background.png")),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSize.pw16),
          child: Form(
            key: _FormKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset("assets/images/logo.png", height: AppSize.h45),
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
                    if (errorMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSize.h8),
                        child: Text(errorMessage!, style: TextStyle(color: Colors.red)),
                      ),
                    SizedBox(height: AppSize.ph24),
                    ElevatedButton(
                      onPressed: () {
                        if (_FormKey.currentState?.validate() ?? false) {
                          register();
                        }
                      },
                      child: isLoading ? CircularProgressIndicator() : Text("Sign Up"),
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
          ),
        ),
      ),
    );
  }
}
