import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class LeaderboardPlayer extends StatelessWidget {
  final String name;
  final String score;
  const LeaderboardPlayer({
    super.key,
    required this.name,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 2,
          child: Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Saira',
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            score,
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'Saira',
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
