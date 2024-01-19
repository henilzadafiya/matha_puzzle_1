import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matha_puzzle_1/data_class.dart';
import 'package:matha_puzzle_1/lvl_page.dart';
import 'package:matha_puzzle_1/second_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class first_page extends StatefulWidget {
  const first_page({Key? key}) : super(key: key);
  static SharedPreferences? prefer;

  @override
  State<first_page> createState() => _first_pageState();
}

class _first_pageState extends State<first_page> {
  bool con = false;
  bool puz = false;
  bool buy = false;

  // int curent_lvl = 0;

  List l = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_prefer();
  }

  get_prefer() async {
    first_page.prefer = await SharedPreferences.getInstance();
    int lvl_number = first_page.prefer!.getInt("lvl_number") ?? 0;
    l = List.filled(data_class.ans.length, "no");
    for (int i = 0; i < lvl_number; i++) {
      l[i] = first_page.prefer!.getString("curent_lvl$i") ?? 0;
    }
    print(l);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(child: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("myasset/image/background.jpg"),
                  fit: BoxFit.cover)),
          child: Column(children: [
            Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Math Puzzles",
                      style:
                      TextStyle(color: Colors.blue.shade900, fontSize: 30)),
                )),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTapDown: (details) {
                              con = true;
                              setState(() {});
                            },
                            onTapCancel: () {
                              con = false;
                              setState(() {});
                            },
                            onTapUp: (details) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return lvl_page();
                                },
                              ));
                              con = false;
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              // alignment: Alignment.center,
                              // width: 130,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: (con == true)
                                      ? Border.all(color: Colors.white)
                                      : null),
                              child: Text(
                                "CONTINUE",
                                style: TextStyle(
                                    fontFamily: "one",
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTapUp: (details) {
                            puz = false;
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return second_page(l);
                              },
                            ));
                            setState(() {});
                          },
                          onTapCancel: () {
                            puz = false;
                            setState(() {});
                          },
                          onTapDown: (details) {
                            puz = true;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: (puz == true)
                                    ? Border.all(color: Colors.white)
                                    : null),
                            // alignment: Alignment.center,
                            // width: 120,
                            child: Text(
                              "PUZZLES",
                              style: TextStyle(
                                  fontFamily: "one",
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTapDown: (details) {
                        buy = true;

                        setState(() {});
                      },
                      onTapCancel: () {
                        buy = false;
                        setState(() {});
                      },
                      onTapUp: (details) {
                        buy = false;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        // alignment: Alignment.center,
                        // width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: (buy == true)
                                ? Border.all(color: Colors.white)
                                : null),
                        child: Text(
                          "BUY PRO",
                          style: TextStyle(
                              fontFamily: "one",
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          "myasset/image/blackboard_main_menu.png"),
                      fit: BoxFit.fill),
                ),),),
            Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20, right: 10),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                  AssetImage("myasset/image/shareus.png"),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 20, right: 15, left: 5),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "myasset/image/emailus.png"))),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 20,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(right: 15, bottom: 20),
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(fontSize: 12),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.black)),
                            ),
                          ],
                        ),
                      ]),
                )),
          ]),
        ),
      ), onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("are you sure exit"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("cancel")),
                TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text("ok")),
              ],
            );
          },
        );
        return true;
      },),
    );
  }
}
