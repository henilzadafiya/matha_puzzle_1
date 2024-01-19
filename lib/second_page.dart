import 'package:flutter/material.dart';
import 'package:matha_puzzle_1/data_class.dart';
import 'package:matha_puzzle_1/first_page.dart';
import 'package:matha_puzzle_1/lvl_page.dart';

class second_page extends StatefulWidget {
  List l;
  second_page(this.l);
  @override
  State<second_page> createState() => _second_pageState();
}

class _second_pageState extends State<second_page> {
  int lvl_number = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shre_prefers();
  }

  shre_prefers() async {
    // first_page.prefer = await SharedPreferences.getInstance();
    lvl_number = first_page.prefer!.getInt("lvl_number") ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("myasset/image/background.jpg"),
                fit: BoxFit.fill)),
        child: Column(children: [
          Container(
            child: Text("Select Puzzle",
                style: TextStyle(
                    color: Colors.blue.shade900,
                    fontSize: 30,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 10,
            child: GridView.builder(
              itemCount: data_class.lvl.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (lvl_number > index) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return lvl_page(index);
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: (lvl_number > index)
                        ? Text(
                            "${index + 1}",
                            style: TextStyle(fontSize: 35),
                          )
                        : null,
                    decoration: BoxDecoration(
                        image: (lvl_number > index)
                            ? (widget.l[index] == "yes")
                                ? DecorationImage(
                                    image: AssetImage("myasset/image/tick.png"))
                                : null
                            : DecorationImage(
                                image: AssetImage("myasset/image/lock.png")),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 3)),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Expanded(
                //   child: Container(
                //     alignment: Alignment.center,
                //     decoration: BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage("myasset/image/back.png"))),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("myasset/image/next.png"))),
                  ),
                ),
              ],
            ),
          ),
        ]),
      )),
    );
  }
}
