import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currenPage;

  final double itemWidth;

  final int count;

  PageIndicator(this.currenPage, this.count,this.itemWidth);

  Widget buildIndicator(bool isActive) {
    return Container(
      height: itemWidth,
      width: itemWidth,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: isActive ? Colors.amber : Colors.black26,
              shape: BoxShape.circle,
              ),

        ),
      ),
    );
  }

  List<Widget> buildIndicatorList() {
    List<Widget> list = new List();

    for (int i = 0; i < count; i++) {
      list.add(buildIndicator(i == currenPage));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildIndicatorList(),
    );
  }
}