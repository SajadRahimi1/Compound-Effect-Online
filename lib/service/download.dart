import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

Future<void> downloadFile(String url, String fileName) async {
  bool error = false;
  Dio dio = Dio();
  try {
    var dir = await getApplicationDocumentsDirectory();
    url =
        "https://github.com/SajadRahimi1/Book-Audio-Flutter/raw/main/assets/$url";
    await dio.download(
      url,
      "${dir.path}/$fileName",
    );
  } catch (e) {
    error = true;
  }
  error
      ? Get.snackbar("", "",
          icon: Icon(Icons.file_download_off),
          titleText: Text(
            "دانلود",
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            "دانلود با خطا مواجه شد",
            textAlign: TextAlign.right,
          ))
      : Get.snackbar("", "",
          titleText: Text(
            "دانلود",
            textAlign: TextAlign.right,
          ),
          messageText: Text(
            "دانلود با موفقیت انجام شد",
            textAlign: TextAlign.right,
          ),
          icon: Icon(Icons.download_done));
}
