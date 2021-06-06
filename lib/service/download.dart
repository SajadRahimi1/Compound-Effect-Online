import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> downloadFile(String url, String fileName) async {
  bool error = false;
  Dio dio = Dio();
  try {
    var dir = await getApplicationDocumentsDirectory();
    // print(dir.path);
    url =
        "https://github.com/SajadRahimi1/Book-Audio-Flutter/raw/main/assets/$url";
    await dio.download(
      url,
      "${dir.path}/$fileName",
    );
  } catch (e) {
    // print(e);
    error = true;
  }
  error
      ? Fluttertoast.showToast(msg: "دانلود با خطا مواجه شد")
      : Fluttertoast.showToast(msg: "دانلود با موفقیت به اتمام رسید");
}
