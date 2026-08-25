import 'dart:io';

import 'package:country_picker/country_picker.dart' show Country;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/preferences_mangar.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';

class ProfileController extends ChangeNotifier with SafeNotify {
  XFile? selectedImage;
  String? userName;
  String? countryName;
  String? countryCode;





  void pickImage(ImageSource source) async {
    selectedImage = await ImagePicker().pickImage(source: source);
    safeNotify();
  }

  void getUserData() {
    userName = PreferencesMangar().getString("username");
    countryName = PreferencesMangar().getString("country_name");
    countryCode = PreferencesMangar().getString("country_code");
    safeNotify();
  }

  void saveCountry(Country selectedCountry)async {
   await PreferencesMangar().setString("country_name", selectedCountry.name);
   await PreferencesMangar().setString("country_code", selectedCountry.countryCode);
    countryName = selectedCountry.name;
    countryCode = selectedCountry.countryCode;
    safeNotify();
  }
}
