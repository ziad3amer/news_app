import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart' show ImageSource;
import 'package:news_app/core/constans/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custtom_svg_picture.dart';
import 'package:news_app/featuers/auth/login_screen.dart';
import 'package:provider/provider.dart';

import 'profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) => ProfileController(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile"), centerTitle: true),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSize.ph24, horizontal: AppSize.pw20),
            child: Consumer<ProfileController>(
              builder: (BuildContext context, ProfileController controller, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          backgroundImage: controller.selectedImage == null
                              ? AssetImage("assets/images/Thumbnail.png")
                              : FileImage(File(controller.selectedImage!.path)),
                          radius: AppSize.r60,
                          backgroundColor: Colors.transparent,
                        ),
                        GestureDetector(
                          onTap: () {
                            showImageSourceDialog(context);
                          },
                          child: Container(
                            width: AppSize.w45,
                            height: AppSize.h45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(AppSize.r100),
                            ),
                            child: Icon(Icons.camera_alt),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.ph8),
                    Text(
                      PreferencesMangar().getString("user_email") ?? "",
                      style: TextStyle(color: Colors.black, fontSize: AppSize.sp16),
                    ),
                    SizedBox(height: AppSize.ph16),

                    _buildItem("Profile Info", "assets/images/Icon.svg", () {}),
                    _buildItem("Language", "assets/images/world.svg", () {}),
                    _buildItem("Country", "assets/images/alaam.svg", () {}),
                    _buildItem("Terms & Conditions", "assets/images/terms.svg", () {}),
                    _buildItem(
                      "Logout",
                      "assets/images/logout.svg",
                      () async{
                       await PreferencesMangar().remove;
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                         return LoginScreen();
                       }));
                      },
                      color: LightColor.primaryColor,
                      withDivider: false,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void showImageSourceDialog(BuildContext context) {
    final controller = context.read<ProfileController>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Choose Image Source", style: TextStyle(fontSize: AppSize.sp16)),
          children: [
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              padding: EdgeInsets.all(AppSize.pw16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSize.pw8),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              padding: EdgeInsets.all(AppSize.pw16),
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: AppSize.pw8),
                  Text("Gallery"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem(
    String title,
    String path,
    Function onTap, {
    Color color = const Color(0xFF161F1B),
    bool withDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(),
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: TextStyle(color: color, fontSize: AppSize.sp16, fontWeight: FontWeight.w400),
          ),
          leading: CusttomSvgPicture.withColorFilter(path: path),
          trailing: CusttomSvgPicture.withColorFilter(
            path: "assets/images/croos.svg",
            height: AppSize.w16,
            width: AppSize.w16,
          ),
        ),
        if (withDivider) Divider(color: Color(0xFFD1DAD6)),
      ],
    );
  }
}
