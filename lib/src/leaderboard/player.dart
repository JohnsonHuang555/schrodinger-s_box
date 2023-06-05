import 'package:flutter/material.dart';

class LeaderboardPlayer extends StatelessWidget {
  final String name;
  final String score;
  final bool highlight;
  const LeaderboardPlayer({
    super.key,
    required this.name,
    required this.score,
    required this.highlight,
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
              color: highlight ? Colors.orange[900] : null,
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
              color: highlight ? Colors.orange[900] : null,
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
