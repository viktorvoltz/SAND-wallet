import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 5, 106, 189),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            )
          ),
        ),
      ),
    );
  }
}