import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matha_puzzle_1/data_class.dart';
import 'package:matha_puzzle_1/first_page.dart';
import 'package:matha_puzzle_1/lvl_page.dart';
import 'package:matha_puzzle_1/second_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
// import 'package:share_plus/share_plus.dart';

class win_page extends StatefulWidget {
  int lavel_number;
  bool? skip_l;

  win_page(this.lavel_number, [this.skip_l]);

  @override
  State<win_page> createState() => _win_pageState();
}

class _win_pageState extends State<win_page> {
  bool con = false;
  bool mai = false;
  bool bay = false;
  bool shr = false;

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("myasset/image/background.jpg"),
              fit: BoxFit.fill),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "PUZZLE ${widget.lavel_number} COMPLETED",
                  style: TextStyle(fontSize: 20),
                ),
              ))
            ],
          ),
          Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("myasset/image/trophy.png"))),
              )),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.center,
              child: Column(children: [
                Expanded(
                  child: GestureDetector(
                    onTapUp: (details) {
                      con = false;
                      if (widget.skip_l == true) {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return lvl_page(widget.lavel_number);
                          },
                        ));
                      } else {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return lvl_page();
                          },
                        ));
                      }
                      setState(() {});
                    },
                    onTapDown: (details) {
                      con = true;
                      setState(() {});
                    },
                    onTapCancel: () {
                      con = false;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.all(5),
                      alignment: Alignment.center,
                      child: Text("CONTINUE",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600)),
                      width: 160,
                      // height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black, width: 1),
                        color: (con == true) ? Colors.white : null,
                        gradient: (con == false)
                            ? LinearGradient(
                                colors: [
                                  Colors.grey,
                                  Colors.white,
                                  Colors.grey
                                ],
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                      onTapUp: (details) {
                        mai = false;
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return first_page();
                          },
                        ));

                        setState(() {});
                      },
                      onTapDown: (details) {
                        mai = true;
                        setState(() {});
                      },
                      onTapCancel: () {
                        mai = false;
                        setState(() {});
                      },
                      child: Container(
                          margin: EdgeInsetsDirectional.all(5),
                          alignment: Alignment.center,
                          child: Text("MAIN MENU",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600)),
                          width: 160,
                          // height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black, width: 1),
                            color: (mai == true) ? Colors.white : null,
                            gradient: (mai == false)
                                ? LinearGradient(
                                    colors: [
                                      Colors.grey,
                                      Colors.white,
                                      Colors.grey
                                    ],
                                  )
                                : null,
                          ))),
                ),
                Expanded(
                  child: GestureDetector(
                      onTapUp: (details) {
                        bay = false;
                        setState(() {});
                      },
                      onTapDown: (details) {
                        bay = true;
                        setState(() {});
                      },
                      onTapCancel: () {
                        bay = false;
                        setState(() {});
                      },
                      child: Container(
                          margin: EdgeInsetsDirectional.all(5),
                          alignment: Alignment.center,
                          child: Text("BUY PRO",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600)),
                          width: 160,
                          // height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black, width: 1),
                            color: (bay == true) ? Colors.white : null,
                            gradient: (bay == false)
                                ? LinearGradient(
                                    colors: [
                                      Colors.grey,
                                      Colors.white,
                                      Colors.grey
                                    ],
                                  )
                                : null,
                          ))),
                ),
              ]),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 20),
                alignment: Alignment.topCenter,
                child: Text("SHARE THIS PUZZLE",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(
                child: GestureDetector(
                  onTapUp: (details) {
                    shr = false;
                    getImageFileFromAssets(
                            "${data_class.share_lvl[widget.lavel_number-1]}")
                        .then((value) {
                      Share.shareFiles(['${value.path}'],
                          text: 'Great picture');
                    });
                    setState(() {});
                  },
                  onTapDown: (details) {
                    shr = true;
                    setState(() {});
                  },
                  onTapCancel: () {
                    shr = false;

                    // Share.shareXFiles(['${directory.path}/image.jpg'], text: 'Great picture');

                    setState(() {});
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black, width: 1),
                        color: (shr == true) ? Colors.white : null,
                        gradient: (shr == false)
                            ? LinearGradient(
                                colors: [
                                  Colors.grey,
                                  Colors.white,
                                  Colors.grey
                                ],
                              )
                            : null,
                        image: DecorationImage(
                            image: AssetImage("myasset/image/shareus.png"))),
                  ),
                ),
              ),
            ],
          )),
          Expanded(child: Container())
          // Expanded(child: Container()),
        ]),
      )),
    );
  }
}
