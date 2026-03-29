import 'dart:io';
import 'package:flutter/material.dart';

class ProfileImageNotifier extends ValueNotifier<File?> {
  ProfileImageNotifier() : super(null);

  void updateImage(File image) {
    value = image;
  }
}

final profileImageNotifier = ProfileImageNotifier();
