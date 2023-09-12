import 'package:athome/Config/property.dart';
import 'package:flutter/material.dart';


SnackBar noInternetSnackBar = SnackBar(
  duration: const Duration(seconds: 4),
  content: const Text(
    'You\'re offline, connect to a network.',
  ),
  backgroundColor: mainColorGrey,
);
SnackBar internetBackSnackBar = const SnackBar(
  duration: Duration(seconds: 3),
  content: Text(
    'You\'re online ✅',
  ),
  backgroundColor: Colors.green,
);