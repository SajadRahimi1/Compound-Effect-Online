import 'dart:io';
import 'package:audio_compound_effect/service/Player.dart';
import 'package:audio_compound_effect/service/download.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModitationScreen(),
    );
  }
}

class ModitationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            CustomeBody(),
          ],
        ),
      ),
    );
  }
}

class CustomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List _audioNames = [
      "مقدمه",
      "فصل ۱",
      "فصل ۲",
      "فصل ۳",
      "فصل ۴",
      "فصل ۵",
      "فصل ۶"
    ];
    List _audioTime = [
      "9:26",
      "35:42",
      "1:00:37",
      "1:12:16",
      "44:46",
      "44:01",
      "35:23"
    ];
    List _audioPath = [
      "intro.mp3",
      "season1.mp3",
      "season2.mp3",
      "season3.mp3",
      "season4.mp3",
      "season5.mp3",
      "season6.mp3",
    ];
    List _audioSize = [
      "2.5MB",
      "8.6MB",
      "14.3MB",
      "16.9MB",
      "10.6MB",
      "8.6MB",
      "10.4MB",
      "8.5MB"
    ];
    String _dir = "";
    Future<void> getDir() async {
      var _get = await getApplicationDocumentsDirectory();
      _dir = _get.path;
    }

    getDir();
    return GetMaterialApp(
      home: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: FloatingActionButton(
                onPressed: () {
                  Player().pause();
                  Get.snackbar("", "",
                      messageText: Text("هیچ فایلی در حال پخش وجود ندارد",
                          textAlign: TextAlign.right),
                      icon: Icon(Icons.pause));
                },
                child: Icon(
                  Icons.pause,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.93,
              padding: EdgeInsets.symmetric(horizontal: 35),
              margin: EdgeInsets.only(bottom: 130),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: _audioNames.length,
                itemExtent: 45,
                itemBuilder: (context, index) => ListTile(
                  leading: Text(_audioTime[index]),
                  title: Text(
                    _audioNames[index],
                    textAlign: TextAlign.right,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.play_arrow),
                    iconSize: 22,
                    onPressed: () {
                      if (File("$_dir/${_audioPath[index]}").existsSync()) {
                        Player().play(_audioPath[index]);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "!فایل صوتی یافت نشد",
                                  textAlign: TextAlign.right,
                                ),
                                content: Text(
                                  "فایل صوتی ابتدا باید دانلود شود سپس پخش شود",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(color: Colors.red),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("بستن")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        downloadFile(_audioPath[index],
                                            _audioPath[index]);
                                        // Fluttertoast.showToast(
                                        //     msg:
                                        //         "درحال دانلود \"${_audioNames[index]}\"");
                                        Get.snackbar("", "",
                                            icon: Icon(Icons.download),
                                            titleText: Text(
                                              "دانلود",
                                              textAlign: TextAlign.right,
                                            ),
                                            messageText: Text(
                                              "درحال دانلود \" ${_audioNames[index]}\" ",
                                              textAlign: TextAlign.right,
                                            ));
                                      },
                                      child: Text(
                                          "(${_audioSize[index]}) دانلود")),
                                ],
                              );
                            });
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(alignment: Alignment.topCenter, children: [
      HeaderBackground(),
      Center(
        child: Container(
          alignment: Alignment.center,
          height: height / 1.28,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("خروج از برنامه",
                                  textAlign: TextAlign.right),
                              content: Text(
                                "آیا اطمینان دارید که می خواهید از برنامه خارج شوید؟",
                                textAlign: TextAlign.right,
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("بازگشت به برنامه")),
                                TextButton(
                                    onPressed: () {
                                      exit(0);
                                    },
                                    child: Text("خروج")),
                              ],
                            );
                          });
                    },
                  ),
                ],
              ),
              Container(
                width: width / 2.4,
                height: height / 320,
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
      Container(
          width: width / 1.4,
          height: height / 3.1,
          margin: EdgeInsets.only(top: height / 2.37),
          child: Image.asset("assets/images/Sajad.png")),
    ]);
  }
}

class HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.height / 4.22,
          margin: EdgeInsets.only(top: 275),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 50,
                spreadRadius: 10,
                color: Colors.blueGrey.shade500)
          ]),
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            margin: EdgeInsets.only(top: 5),
            height: MediaQuery.of(context).size.height / 1.5,
            color: Colors.white,
          ),
        ),
        ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: Color(0xFF145e87),
                image: DecorationImage(
                    image: AssetImage("assets/images/splash.png"),
                    fit: BoxFit.fill),
              ),
            ))
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    var sw = size.width;
    var sh = size.height;
    path.lineTo(sw, 0);
    path.lineTo(sw, sh);
    path.cubicTo(sw, sh * 0.7, 0, sh * 0.6, 0, sh * 0.55);
    path.lineTo(0, sh);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
