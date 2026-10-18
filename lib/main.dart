import 'dart:developer';
import 'package:flutter/material.dart';

import 'functions.dart';
import 'package:hugeicons/hugeicons.dart';

void main() {
  runApp(xoxApp());
}

class xoxApp extends StatelessWidget {
  const xoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'xoxApp', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool turn = true; // turn
  bool isdun = false;
  double sBoxSize = 80;

  Widget drawValue(Boxes a) {
    if (a.state == false) {
      return Text('');
    } else if (a.value == true) {
      return Text(
        'X',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
      );
    } else {
      return Text(
        'O',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
      );
    }
  }

  void returnAll() {
    for (int i = 0; i < 9; i++) {
      boxList[i].state = false;
      boxList[i].value = null;
    }
    turn = true;
    isdun = false;
  }

  bool checkWinner() {
    List<List<int>> checkList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],

      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],

      [0, 4, 8], //sol-sağ
      [2, 4, 6], //sağ-sol
    ];

    for (var check in checkList) {
      var place1 = boxList[check[0]].value;

      var place2 = boxList[check[1]].value;

      var place3 = boxList[check[2]].value;

      if (place1 != null && place1 == place2 && place2 == place3) {
        return true;
      }
    }
    return false;
  }

  bool areAllBoxesFilled() {
    for (int i = 0; i < 9; i++) {
      if (!boxList[i].state) {
        return false;
      }
    }
    return true;
  }

  bool checkDraw() {
    if (areAllBoxesFilled() && !checkWinner()) {
      return true;
    } else {
      return false;
    }
  }

  void dunScreen() {
    isdun = true;
    sBoxSize = 40;
  }

  Widget last() {
    if (checkWinner() || checkDraw()) {
      return GestureDetector(
        onTap: () {
          setState(() {
            sBoxSize = 80;

            returnAll();
          }); // setState burada kapanmalı
        }, // onTap fonksiyonu burada kapanmalı
        child: Container(
          width: 300,
          height: 70,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 205, 67, 67),
            borderRadius: BorderRadius.all(Radius.circular(45)),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'oyun bitti ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(width: 10),
              Icon(Icons.replay, size: 34, fontWeight: FontWeight.bold),
            ],
          ),
        ),
      );
    } else {
      return Text('');
    }
  }

  Widget turnText(String a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HugeIcon(icon: HugeIcons.strokeRoundedJoystick04, size: 40),
        SizedBox(width: 15),
        Text(a, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40)),
      ],
    );
  }

  Widget firstText() {
    if (checkDraw()) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'berabere',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
          ),
          SizedBox(width: 10),
          HugeIcon(icon: HugeIcons.strokeRoundedAgreement02, size: 40),
        ],
      );
    }

    if (checkWinner()) {
      return turn == false
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'X kazandı',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                ),
                SizedBox(width: 10),
                HugeIcon(icon: HugeIcons.strokeRoundedAward01, size: 40),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'O kazanadı',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
                ),
                SizedBox(width: 10),
                HugeIcon(icon: HugeIcons.strokeRoundedAward01, size: 40),
              ],
            );
    } else {
      return turn == false ? turnText('O') : turnText('X');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 126, 12, 115),
        title: Text(
          'merve selam',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 50,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: sBoxSize),
            firstText(),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3, // yataydaki eleman sayısı
              crossAxisSpacing: 15, // yatay elemanalar arası boşluk
              mainAxisSpacing: 15, //dikey elemanlar arası boşluk
              padding: EdgeInsets.all(40),
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () {
                    log("Tıklandı");
                    setState(() {
                      if (!checkWinner()) {
                        if (boxList[index].state == false) {
                          boxList[index].value = turn;
                          boxList[index].state = true;
                          turn = !turn;
                          if (checkWinner()) {
                            dunScreen();
                          }
                        }
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 11, 157, 35),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(child: drawValue(boxList[index])),
                  ),
                );
              }),
            ),

            last(),
          ],
        ),
      ),
    );
  }
}
