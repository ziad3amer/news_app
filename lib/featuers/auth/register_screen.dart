import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';
import 'package:news_app/featuers/auth/login_screen.dart';
import 'package:news_app/featuers/home/home_screen.dart';
import 'package:news_app/featuers/main/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _FormKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? errorMessage;
  bool isLoading = false;

  void register() async {
    setState(() {
      errorMessage=null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 3));
    final savedEmail = PreferencesMangar().getString("user_email");
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = "Email Already Exist";
        isLoading = false;
      });
    } else {
      await PreferencesMangar().setString("user_email", emailController.text);
      await PreferencesMangar().setString(
        "user_password",
        passwordController.text,
      );
      await PreferencesMangar().setBoll("is_logged_in", true);
      setState(() {
        isLoading=false;
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
  }

  bool isVisible = false;

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
            key: _FormKey,
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
                SizedBox(height: 24),
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
                if(errorMessage!=null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(errorMessage!,style: TextStyle(color: Colors.red),),
                ),
                SizedBox(height: 24,),
                ElevatedButton(
                  onPressed: () {
                    if (_FormKey.currentState?.validate() ?? false) {
                      register();
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text("Sign Up"),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account ?", style: TextStyle(fontSize: 14)),
                    SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Text(
                        "Sign In",
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
