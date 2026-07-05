import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/featuers/main/main_screen.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool isVisible = false;
  String? errorMessage;
  bool isLoading = false;

  final GlobalKey<FormState> _form = GlobalKey();

  void login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 3));

    final savedEmail = PreferencesMangar().getString("user_email");
    final savedPassword = PreferencesMangar().getString("user_password");
    if (savedEmail == null || savedPassword == null) {
      setState(() {
        errorMessage = "No Account Found Please Register First";
        isLoading=false;
      });
      return;
    }
    if (savedEmail != emailController.text || savedPassword != passwordController.text) {
      setState(() {
        errorMessage = "Incorrect Email or Password";
        isLoading=false;
      });
      return;
    }
    await PreferencesMangar().setBoll("is_logged_in", true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );
    setState(() {
      errorMessage = null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/logo.png", height: 45),
                ),
                SizedBox(height: 40),
                Text(
                  'Welcome to Newts',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 24),
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
                SizedBox(height: 24),
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
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_form.currentState?.validate() ?? false) {
                      login();
                    }
                  },
                  child: isLoading
                      ?CircularProgressIndicator()
                      : Text("Sign In"),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t have an account ?",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(width: 8),
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
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
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
  }
}
