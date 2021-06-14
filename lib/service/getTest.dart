import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Change extends GetxController {
  late var indexPlay = -1.obs;
  late var icon =
      IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)).obs;
  void playIndex(var index) {
    indexPlay = index;
    update();
  }

  Rx<IconButton> setIcon(int index, void Function() onPRS) {
    if (index == indexPlay)
      icon = IconButton(onPressed: onPRS, icon: Icon(Icons.play_circle)).obs;
    if (index != indexPlay)
      icon = IconButton(onPressed: onPRS, icon: Icon(Icons.play_arrow)).obs;
    return icon;
  }
}
