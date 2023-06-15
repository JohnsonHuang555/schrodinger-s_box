import 'package:flutter/material.dart';

class LeaderboardPlayer extends StatelessWidget {
  final int? rank;
  final String name;
  final String score;
  final bool highlight;
  const LeaderboardPlayer({
    super.key,
    required this.name,
    required this.score,
    required this.highlight,
    this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        rank != null
            ? SizedBox(
                width: 20,
                child: Center(
                  child: Text(
                    rank.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Saira',
                    ),
                  ),
                ),
              )
            : Container(),
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
              color: highlight ? Colors.deepOrange[800] : null,
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
              color: highlight ? Colors.deepOrange[800] : null,
            ),
          ),
        ),
      ],
    );
  }
}
