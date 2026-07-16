import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_helper.dart';
import '../models/match.dart';
import '../services/tournament_engine.dart';

class MatchNotifier extends StateNotifier<List<Match>> {
  MatchNotifier() : super([]);

  final DatabaseHelper _database = DatabaseHelper.instance;

  Future<void> loadMatches(int tournamentId) async {
    state = await _database.getMatches(tournamentId);
  }

  Future<void> generateTournament(int tournamentId) async {
    state = await TournamentEngine.generateRoundOne(tournamentId);
  }

  Future<void> generateRandomWinners(int tournamentId) async {
    await TournamentEngine.generateRandomWinners(tournamentId);
    await loadMatches(tournamentId);
  }

  Future<void> clearMatches(int tournamentId) async {
    await _database.deleteMatches(tournamentId);
    state = [];
  }
}

final matchProvider = StateNotifierProvider<MatchNotifier, List<Match>>(
  (ref) => MatchNotifier(),
);
