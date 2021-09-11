import 'dart:async';

import 'package:flutter/widgets.dart';

class EnticerOpenerPage extends StatefulWidget {
  const EnticerOpenerPage({Key? key}) : super(key: key);

  @override
  _EnticerOpenerPageState createState() => _EnticerOpenerPageState();
}

class _EnticerOpenerPageState extends State<EnticerOpenerPage> {
  int index = 0;

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 2),
      (timer) {
        setState(() {
          if (index == 4) {
            print('show the other one');
          } else {
            index++;
          }
        });
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder,
        duration: const Duration(milliseconds: 400),
        child: IndexedStack(
          alignment: Alignment.center,
          key: ValueKey<int>(index),
          index: index,
          children: [
            Image.asset('assets/opener/slide1.jpg'),
            Image.asset('assets/opener/slide2.jpg'),
            Image.asset('assets/opener/slide3.jpg'),
            Image.asset('assets/opener/slide4.jpg'),
          ],
        ));
  }
}
