
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHelper {
  static String getSourceByPng(
    String imageName, {
    String? customPath,
  }) {
    final String assetPath = customPath ?? 'assets/';

    return '$assetPath$imageName${imageName.endsWith('.png') ? '' : '.png'}';
  }
}
