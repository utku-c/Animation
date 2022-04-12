// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';

class AnimationView extends StatefulWidget {
  AnimationView({Key? key}) : super(key: key);

  @override
  State<AnimationView> createState() => _AnimationViewState();
}

class _AnimationViewState extends State<AnimationView> {
  bool isAnimatedAlign = false;
  late Timer timer;
  int _start = 10;
  double width = 0;

  void startTimer() {
    final deviceWith = MediaQuery.of(context).size.width;
    final onePeriod = deviceWith / 10;
    final oneSec = Duration(seconds: 1);

    timer = Timer.periodic(oneSec, (timer) {
      if (_start < 1) {
        showDialog(
            context: context,
            builder: (val) => Dialog(
                  child: Text("Tamamlandı"),
                ));
        timer.cancel();
      } else {
        setState(() {
          width = width + onePeriod;
        });
        _start--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: isAnimatedAlign
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              duration: Duration(milliseconds: 2000),
              child: Container(
                width: 100,
                height: 100,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isAnimatedAlign = !isAnimatedAlign;
                    });
                  },
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            width: width,
            height: 200,
            color: Colors.red,
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
