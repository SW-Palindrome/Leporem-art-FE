import 'package:flutter/material.dart';

class SingleGestureDetector extends StatelessWidget {
  final Widget child;
  final Function() onTap;

  bool singleTap = false;

  SingleGestureDetector(
      {Key? key, required this.child, required this.onTap, singleTap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (!singleTap) {
            Function.apply(onTap, []);
            singleTap = true;
            Future.delayed(const Duration(seconds: 3))
                .then((value) => singleTap = false);
          }
        },
        child: child);
  }
}
