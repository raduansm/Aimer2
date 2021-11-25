import 'package:flutter/material.dart';

class CompletedList extends StatelessWidget {
  final int? index;

  CompletedList({@required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.album_outlined,
            color: Colors.grey,
          ),
          SizedBox(
            width: 15,
          ),
          Text("Completed Task $index"),
          Spacer(),
          Icon(
            Icons.circle,
            color: Colors.greenAccent,
            size: 15,
          ),
        ],
      ),
    );
  }
}
