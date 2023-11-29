// ignore_for_file: file_names

import 'package:athome/Language/ar.dart';
import 'package:athome/Language/en.dart';
import 'package:athome/Language/kur.dart';
import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {"en": en, "ar": ar, "kur": kur};
}
