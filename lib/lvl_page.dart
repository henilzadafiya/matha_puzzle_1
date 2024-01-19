import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matha_puzzle_1/data_class.dart';
import 'package:matha_puzzle_1/first_page.dart';
import 'package:matha_puzzle_1/win_page.dart';

class lvl_page extends StatefulWidget {
  int? ind;

  lvl_page([this.ind]);

  static bool t = false;

  @override
  State<lvl_page> createState() => _lvl_pageState();
}

class _lvl_pageState extends State<lvl_page> {
  TextEditingController t1 = TextEditingController();
  int lvl_number = 0;
  String str = "";
  int sec = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shre_prefers();
    if (widget.ind != null) {
      lvl_number = widget.ind!;
    } else {
      // lvl_number1 = first_page.prefer!.getInt("lvl_number1") ?? 0;
      lvl_number = first_page.prefer!.getInt("lvl_number") ?? 0;
    }
    print("widget=${widget.ind}");
    print("leval_n= $lvl_number");
    // print("leval_n1= $lvl_number1");
    setState(() {});
    //   shre_prefers();
  }

  shre_prefers() async {
    // first_page.prefer = await SharedPreferences.getInstance();
    lvl_number = first_page.prefer?.getInt("lvl_number") ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
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
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return first_page();
                          },
                        ));
                      },
                      child: Text("ok")),
                ],
              );
            },
          );
          return true;
        },
        child: SafeArea(
            child: Container(
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("SKIP!"),
                              content: Text(
                                  "Wait for ${30 - sec} second after that you can this skip level"),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("CANCEL"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (first_page.prefer!
                                                .getString("skip_time") !=
                                            null) {
                                          DateTime dt = DateTime.now();
                                          String part_time = first_page.prefer!
                                                  .getString("skip_time") ??
                                              "";
                                          DateTime dt1 =
                                              DateTime.parse(part_time);
                                          sec = dt.difference(dt1).inSeconds;
                                          if (sec >= 30) {
                                            String skip_time =
                                                DateTime.now().toString();
                                            first_page.prefer!.setString(
                                                "skip_time", skip_time);
                                            first_page.prefer!.setString(
                                                "curent_lvl$lvl_number", "no");

                                            setState(() {});
                                            //lvl_number++;
                                            first_page.prefer!.setInt(
                                                "lvl_number", lvl_number);
                                          }
                                        } else {
                                          String skip_time =
                                              DateTime.now().toString();
                                          first_page.prefer!.setString(
                                              "skip_time", skip_time);
                                          first_page.prefer!.setString(
                                              "curent_lvl$lvl_number", "no");
                                          lvl_number++;
                                          first_page.prefer!
                                              .setInt("lvl_number", lvl_number);
                                          Navigator.pop(context);
                                        }
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return lvl_page();
                                          },
                                        ));
                                        // lvl_number++;
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, right: 30),
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("myasset/image/skip.png"))),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Puzzle ${lvl_number + 1}",
                        style: TextStyle(fontSize: 25)),
                    margin: EdgeInsets.only(top: 10),
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("myasset/image/level_board.png"),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("${data_class.hint[lvl_number]}"),
                              actions: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return lvl_page();
                                      },
                                    ));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    child: Text("OK"),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 30),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("myasset/image/hint.png"))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10, bottom: 220),
                  // width: 350,
                  // height: 200,
                  // height: double.infinity,
                  // width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("${data_class.lvl[lvl_number]}"))),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  child: Column(children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child:
                                Text(t1.text, style: TextStyle(fontSize: 20)),
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Expanded(
                            child: InkWell(
                          onLongPress: () {
                            if (t1.text != "") {
                              t1.text = "";
                            }
                            setState(() {});
                          },
                          onTap: () {
                            if (t1.text != "") {
                              t1.text =
                                  t1.text.substring(0, t1.text.length - 1);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "myasset/image/delete.png"))),
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            if (t1.text == data_class.ans[lvl_number]) {

                              if (widget.ind == null) {
                                lvl_page.t = true;
                                first_page.prefer!
                                    .setString("curent_lvl$lvl_number", "yes");
                                lvl_number++;
                                first_page.prefer
                                    ?.setInt("lvl_number", lvl_number);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return win_page(lvl_number);
                                    },
                                  ),
                                );
                              }
                             else{
                                first_page.prefer!
                                    .setString("curent_lvl$lvl_number", "yes");
                                lvl_number++;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return win_page(lvl_number,true);
                                    },
                                  ),
                                );
                              }
                            } else {
                              if (t1.text != "") {
                                t1.text = "";
                                Fluttertoast.showToast(
                                    msg: "wron!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(SnackBar(
                                //   content: Text("Wrong!"),
                                //   behavior: SnackBarBehavior.floating,
                                //   width: 100,
                                //   duration: Duration(seconds: 3),
                                // ));
                              }
                            }
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            child: Text("Submit",
                                style: TextStyle(color: Colors.white)),
                          ),
                        )),
                      ],
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        btn_ui("1"),
                        btn_ui("2"),
                        btn_ui("3"),
                        btn_ui("4"),
                        btn_ui("5"),
                        btn_ui("6"),
                        btn_ui("7"),
                        btn_ui("8"),
                        btn_ui("9"),
                        btn_ui("0"),
                      ],
                    )),
                  ]),
                )),
          ]),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("myasset/image/gameplaybackground.jpg"),
                  fit: BoxFit.fill)),
        )),
      ),
    );
  }

  get(String str) {
    t1.text = t1.text + "$str";
  }

  Widget btn_ui(String str) {
    return InkWell(
      onTap: () {
        get(str);
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        width: 25,
        height: 35,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white, width: 1)),
        child: Text("$str",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
/*
* if (first_page.prefer!.getString("skip_time") != null) {
                        DateTime dt = DateTime.now();
                        String ago_time =
                            first_page.prefer!.getString("skip_time") ?? "";
                        DateTime dt1 = DateTime.parse(ago_time);
                        int sec = dt.difference(dt1).inSeconds;
                        if (sec >= 30) {
                          String skip_time = DateTime.now().toString();
                          first_page.prefer!.setString("skip_time", skip_time);
                          first_page.prefer!.setString("curent_lvl$lvl_number", "no");
                          setState(() {
                            lvl_number++;
                          });
                          first_page.prefer!.setInt("lvl_number", lvl_number);
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return win_page(lvl_number);
                            },
                          ));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Wait for ${30 - sec} second after that you can this skip level"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        String skip_time = DateTime.now().toString();
                        first_page.prefer!.setString("lvl_number", skip_time);
                        first_page.prefer!
                            .setString("curent_lvl$lvl_number", "no");
                        setState(() {
                          lvl_number++;
                        });
                        first_page.prefer!.setInt("lvl_number", lvl_number);
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return win_page(lvl_number);
                          },
                        ));
                      }*/
