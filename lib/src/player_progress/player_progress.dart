// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'persistence/player_progress_persistence.dart';

/// Encapsulates the player's progress.
class PlayerProgress extends ChangeNotifier {
  static const maxHighestScoresPerPlayer = 10;

  final PlayerProgressPersistence _store;

  int _highestLevelReached = 0;
  String _userId = '';
  String _playerName = '';
  String _yourScore = '100'; // 預設
  int _yourRank = 0;

  bool _showCreateUserModal = false;

  /// Creates an instance of [PlayerProgress] backed by an injected
  /// persistence [store].
  PlayerProgress(PlayerProgressPersistence store) : _store = store;

  /// The highest level that the player has reached so far.
  int get highestLevelReached => _highestLevelReached;

  String get userId => _userId;
  String get playerName => _playerName;
  String get yourScore => _yourScore;
  int get yourRank => _yourRank;

  bool get showCreateUserModal => _showCreateUserModal;

  FirebaseFirestore db = FirebaseFirestore.instance;

  /// Fetches the latest data from the backing persistence store.
  Future<void> getLatestFromStore() async {
    final userId = await _store.getUserId();
    _userId = userId;
    if (userId == '') {
      var uuid = Uuid();
      var createdId = uuid.v4();
      await _store.setUserId(createdId);
      _showCreateUserModal = true;
    } else {
      final usersRef = db.collection('users');
      await usersRef.doc(userId).get().then((doc) async {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          _playerName = data['name'] as String;
          _yourScore = data['score'].toString();
          final rank = await getUserRank();
          _yourRank = rank;
        } else {
          _showCreateUserModal = true;
        }
      });
    }
    notifyListeners();
  }

  /// Resets the player's progress so it's like if they just started
  /// playing the game for the first time.
  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
  }

  /// Registers [level] as reached.
  ///
  /// If this is higher than [highestLevelReached], it will update that
  /// value and save it to the injected persistence store.
  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();

      unawaited(_store.saveHighestLevelReached(level));
    }
  }

  void setPlayerName(String name) {
    _playerName = name;
  }

  Future<void> savePlayerName() async {
    final city = {
      'name': playerName,
      'score': 100,
    };

    await db.collection('users').doc(userId).set(city);

    _showCreateUserModal = false;
  }

  Future<bool> saveNewScore(String score) async {
    final data = {'score': double.parse(score).round()};
    await db.collection('users').doc(userId).set(data, SetOptions(merge: true));

    return true;
  }

  Future<int> getUserRank() async {
    final usersRef = db.collection('users');

    // 步驟1：取得自己的使用者資料
    final selfUserDoc = await usersRef.doc(userId).get();
    final selfUser = selfUserDoc.data();

    // 步驟2：取得自己的分數
    final selfScore = selfUser!['score'] as int;

    // 步驟3：查詢分數比自己高的使用者數量
    final higherScoreUsersQuery =
        usersRef.where('score', isGreaterThan: selfScore);
    final higherScoreUsersSnapshot = await higherScoreUsersQuery.get();
    final higherScoreUsersCount = higherScoreUsersSnapshot.docs.length;

    // 步驟4：計算自己的排名
    final selfRank = higherScoreUsersCount + 1;

    return selfRank;
  }
}
