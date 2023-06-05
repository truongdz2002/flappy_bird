import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  double size;
   Barrier( {required this.size}) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: size,
      decoration: BoxDecoration(
          color: Colors.green,
        borderRadius: BorderRadius.circular(20),
        border:Border.all(width: 10,color:Colors.greenAccent)
      ),
    );
  }
}
