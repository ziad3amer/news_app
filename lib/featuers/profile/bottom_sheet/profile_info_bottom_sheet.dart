import 'package:flutter/material.dart';
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loudUserData();
  }

  void _loudUserData() async {
    emailController.text = PreferencesMangar().getString("user_email") ?? "";
    usernameController.text = PreferencesMangar().getString("username") ?? "";
  }

  void _saveUserData() async {
    await PreferencesMangar().setString("user_email", emailController.text);
    await PreferencesMangar().setString("username", usernameController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppSize.r16),
          topRight: Radius.circular(AppSize.r16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: AppSize.h4,
                    width: AppSize.w32,
                    decoration: BoxDecoration(
                      color: Color(0xFF363636),
                      borderRadius: BorderRadius.circular(AppSize.r100),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.ph16),
                Text(
                  "Profile Info",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: AppSize.sp16),
                ),
                SizedBox(height: AppSize.ph16),
                CustomTextFormField(
                  controller: usernameController,
                  hintText: "Ziad Amer",
                  title: "User Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter your User Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppSize.ph16),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Ziad@gmail.com',
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
                SizedBox(height: AppSize.ph40),
                ElevatedButton(
                  onPressed: () {
                    _saveUserData();
                  },
                  child: Text("Save"),
                ),
                SizedBox(height: AppSize.ph16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
