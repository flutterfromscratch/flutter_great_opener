import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onboarder/onboarder/enticer/enticer.dart';

class OnboarderPage extends StatefulWidget {
  const OnboarderPage({Key? key}) : super(key: key);

  @override
  _OnboarderPageState createState() => _OnboarderPageState();
}

class _OnboarderPageState extends State<OnboarderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: true
          ? EnticerOpenerPage()
          : PageView(
              children: [
                OnboardStep(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        'WELCOME TO',
                        style: TextStyle(fontSize: 50),

                        // minFontSize: 20,
                        maxLines: 1,
                      ),
                      AutoSizeText(
                        'SYNERGY',
                        maxLines: 1,
                        style: TextStyle(fontSize: 100),
                      ),
                    ],
                  ),
                )),
                OnboardStep(
                  Text('Page two'),
                ),
              ],
            ),
    );
  }
}

class OnboardStep extends StatelessWidget {
  final Widget? image;
  final Widget text;

  OnboardStep(
    this.text, {
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: [
          if (image != null)
            Expanded(
              child: image!,
              flex: 2,
            ),
          Expanded(
            child: Center(child: text),
            flex: 1,
          ),
        ],
      ),
    );
    // TODO: implement build
    // throw UnimplementedError();
  }
}
