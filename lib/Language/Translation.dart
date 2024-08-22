// Import necessary packages and libraries
import 'package:dllylas/Language/ar.dart';
import 'package:dllylas/Language/en.dart';
import 'package:dllylas/Language/kur.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {"en": en, "ar": ar, "kur": kur};
}
