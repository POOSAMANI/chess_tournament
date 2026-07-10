import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_helper.dart';
import '../models/player.dart';

class PlayerNotifier extends StateNotifier<List<Player>> {
  PlayerNotifier() : super([]) {
    loadPlayers();
  }

  final DatabaseHelper _database = DatabaseHelper.instance;

  Future<void> loadPlayers() async {
    state = await _database.getPlayers();
  }

  Future<void> addPlayer(Player player) async {
    await _database.insertPlayer(player);
    await loadPlayers();
  }

  Future<void> updatePlayer(Player player) async {
    await _database.updatePlayer(player);
    await loadPlayers();
  }

  Future<void> deletePlayer(int id) async {
    await _database.deletePlayer(id);
    await loadPlayers();
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, List<Player>>(
  (ref) => PlayerNotifier(),
);
