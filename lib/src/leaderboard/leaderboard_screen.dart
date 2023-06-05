import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/leaderboard/player.dart';
import 'package:provider/provider.dart';

import '../player_progress/player_progress.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  Future<List<DocumentSnapshot>> getTopTenUsers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('score', descending: true)
        .limit(10)
        .get();

    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    var playerProgress = context.read<PlayerProgress>();

    return FutureBuilder(
      future: getTopTenUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: palette.primary,
            body: Center(
              child: Text('Loading...'),
            ),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        List<dynamic> topTenUsers = snapshot.data as List<dynamic>;

        return Scaffold(
          backgroundColor: palette.primary,
          body: ResponsiveScreen(
            squarishMainArea: Column(
              children: [
                Text(
                  'TOP 10',
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Saira',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(
                  thickness: 3,
                  color: palette.secondary,
                ),
                for (final user in topTenUsers)
                  SingleChildScrollView(
                    child: LeaderboardPlayer(
                      name: user['name'] as String,
                      score: user['score'].toString(),
                      highlight: playerProgress.userId == user.id as String,
                    ),
                  )
              ],
            ),
            rectangularMenuArea: Column(
              children: [
                Divider(
                  thickness: 3,
                  color: palette.secondary,
                ),
                LeaderboardPlayer(
                  name: 'You',
                  score: playerProgress.yourScore,
                  highlight: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
