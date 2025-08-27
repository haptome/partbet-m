import 'dart:ui';

import 'package:partbet/app/core/config/app_assets.dart';
import 'package:partbet/app/core/services/language_service.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class HomeControllers extends GetxController {

  final LanguageService _languageService = LanguageService();

  final isAmharic = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadSites();
    _loadSavedLanguage();
  }

  void loadSites() {

    
  }

  void toggleLanguage() async {
    isAmharic.value = !isAmharic.value;
    final languageCode = isAmharic.value ? 'am' : 'en';
    final countryCode = isAmharic.value ? 'ET' : 'US';
    await _languageService.saveLanguage(languageCode, countryCode);
    _changeLanguage(languageCode, countryCode);
  }

  void _changeLanguage(String languageCode, String countryCode) {
    final locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }

  void _loadSavedLanguage() async {
    final savedLocale = await _languageService.getSavedLocale();
    isAmharic.value = savedLocale.languageCode == 'am';
    Get.updateLocale(savedLocale);
  }

  String get flagAsset =>
      !isAmharic.value ? AppAssets.etFlag : AppAssets.ukFlag;

  String get languageText => !isAmharic.value ? 'አማርኛ' : 'English';
}
