import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/components/fancy_button.dart';
import 'package:game_template/src/leaderboard/player.dart';
import 'package:go_router/go_router.dart';
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

  List<Widget> getPlayers(List<dynamic> topTenUsers, int rank, String userId) {
    List<Widget> list = [];
    for (final user in topTenUsers) {
      list.add(LeaderboardPlayer(
        rank: rank++,
        name: user['name'] as String,
        score: user['score'].toString(),
        highlight: userId == user.id as String,
      ));
    }
    return list;
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
              child: Text(
                'Loading...',
                style: TextStyle(
                  fontFamily: 'Saira',
                  fontSize: 26,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: palette.primary,
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontFamily: 'Saira',
                  fontSize: 26,
                ),
              ),
            ),
          );
        }

        List<dynamic> topTenUsers = snapshot.data as List<dynamic>;
        var rank = 1;

        return Scaffold(
          backgroundColor: palette.primary,
          body: ResponsiveScreen(
            squarishMainArea: Column(
              children: [
                Text(
                  'TOP 10',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Saira',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(
                  thickness: 3,
                  color: palette.secondary,
                ),
                Expanded(
                  child: ListView(
                    children: getPlayers(
                      topTenUsers,
                      rank,
                      playerProgress.userId,
                    ),
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
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FancyButton.text(
                    color: Colors.blueGrey,
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    text: 'BACK',
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
