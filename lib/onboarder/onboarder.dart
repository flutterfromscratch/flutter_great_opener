import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onboarder/onboarder/enticer/enticer.dart';

class OnboarderPage extends StatefulWidget {
  const OnboarderPage({Key? key}) : super(key: key);

  @override
  _OnboarderPageState createState() => _OnboarderPageState();
}

class HolidayType {
  final String asset;
  final String name;

  HolidayType(this.asset, this.name);
}

class _OnboarderPageState extends State<OnboarderPage> {
  bool acceptedLicense = false;
  final outerScrollController = PageController();
  // final innerScrollController = PageController();
  double innerScrollPosition = 0;
  // final innerScrollController

  final holidayTypes = [
    HolidayType('buggy.jpg', 'Driving'),
    HolidayType('cave_diving.jpg', 'Exploring'),
    HolidayType('exploration.jpg', 'Discovery'),
    HolidayType('rafting.jpg', 'Rafting'),
    HolidayType('relaxation.jpg', 'Relaxation'),
    HolidayType('water.jpg', 'Boating'),
  ];

  final selectedHolidayTypes = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: outerScrollController,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          ClipRect(
            child: EnticerOpenerPage(
              getStartedPressed: () => outerScrollController.animateToPage(
                1,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
          Stack(
            children: [
              PageView(
                // controller: innerScrollController,
                onPageChanged: (val) {
                  setState(() {
                    innerScrollPosition = val.toDouble();
                  });
                },
                children: [
                  OnboardStep(
                    [
                      Text(
                        'Get ready for the trip of a lifetime.',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Synergy Holidays is a way for you to holiday, and really enjoy it.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                    image: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset('assets/explore.png'),
                    ),
                  ),
                  OnboardStep(
                    [
                      Text(
                        'But first, we have to keep the lawyers happy.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        'Use of Synergy Travel is guided by the terms and conditions set out in the license agreement.',
                        textAlign: TextAlign.center,
                      ),
                      CheckboxListTile(
                        value: acceptedLicense,
                        onChanged: (val) {
                          setState(() {
                            acceptedLicense = val ?? false;
                          });
                        },
                        title: Text('I accept the license agreement'),
                      )
                    ],
                    image: Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Image.asset('assets/lawyers.png'),
                    ),
                  ),
                  OnboardStep(
                    [
                      Text(
                        'What do you like doing?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: [
                          ...holidayTypes.map(
                            (e) => AnimatedContainer(
                              duration: Duration(milliseconds: 100),
                              padding: selectedHolidayTypes.contains(e.name) ? EdgeInsets.all(16) : EdgeInsets.zero,
                              child: Card(
                                // borderOnForeground: true,
                                semanticContainer: true,
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedHolidayTypes.contains(e.name)) {
                                        selectedHolidayTypes.remove(e.name);
                                      } else {
                                        selectedHolidayTypes.add(e.name);
                                      }
                                    });
                                  },
                                  child: Ink.image(
                                    image: AssetImage(
                                      'assets/holidaytypes/${e.asset}',
                                    ),
                                    fit: BoxFit.cover,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.expand,
                                      children: [
                                        Align(
                                          child: Container(
                                            padding: EdgeInsets.zero,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                e.name,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            width: double.maxFinite,
                                            color: Colors.white,
                                          ),
                                          alignment: Alignment.bottomCenter,
                                        ),
                                        AnimatedOpacity(
                                          opacity: selectedHolidayTypes.contains(e.name) ? 1.0 : 0.0,
                                          duration: Duration(milliseconds: 100),
                                          child: Container(
                                            height: double.maxFinite,
                                            width: double.maxFinite,
                                            color: Colors.grey.withOpacity(0.3),
                                            child: Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  OnboardStep(
                    [
                      Text(
                        "Pack your bags, you're on your way!",
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "That's all the information we need for now. We'll start offering you great holidays tailored to you, once you tap the button below!",
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                title: Text(
                                  "We'd love to, but...",
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "...this is just a demo. Feel free to take a holiday whenever you want, though."),
                                  ),
                                  TextButton(
                                    child: Text("IT'S OKAY, I GET IT"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ),
                            );
                          },
                          child: Text('MATCH ME TO MY NEXT HOLIDAY'))
                    ],
                    image: Image.asset('assets/get_set.png'),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: 4,
                  position: innerScrollPosition,
                  // position: innerScrollController.hasClients ? innerScrollController.page ?? 0 : 0,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class OnboardStep extends StatelessWidget {
  final Widget? image;
  final List<Widget> children;

  OnboardStep(
    this.children, {
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade200,
      // color: Colors.blueAccent,
      child: Column(
        children: [
          if (image != null)
            Expanded(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Card(
                    elevation: 10,
                    child: image!,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              flex: 2,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
