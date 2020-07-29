import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Tipp {
  String name;
  Tipp({this.name});
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tipp> list = [
    Tipp(name: "assets/images/1.jpg"),
    Tipp(name: "assets/images/2.jpg"),
    Tipp(name: "assets/images/3.jpg"),
    Tipp(name: "assets/images/4.jpg"),
    Tipp(name: "assets/images/5.jpg"),
    Tipp(name: "assets/images/6.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 60, left: 20),
          child: Text(
            "Zelda",
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        FotoPageView(
          list: list,
        ),
      ],
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class FotoPageView extends StatefulWidget {
  List<Tipp> list;
  FotoPageView({this.list});

  @override
  _FotoPageViewState createState() => _FotoPageViewState();
}

class _FotoPageViewState extends State<FotoPageView> {
  PageController pageController;
  double viewportFraction = 0.8;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController =
        new PageController(initialPage: 0, viewportFraction: viewportFraction);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
          controller: pageController,
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            double sacle = max(viewportFraction,
                (1 - (pageOffset - index).abs()) + viewportFraction);

            double angle = (pageOffset - index).abs();

            if (angle > 0.5) {
              angle = 1 - angle;
            }

            return Container(
              padding: EdgeInsets.only(
                  left: 15, right: 15, top: 100 - sacle * 25, bottom: 50),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
                alignment: Alignment.center,
                child: Material(
                  elevation: 5,
                  child: Image.asset(
                    widget.list[index].name,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
