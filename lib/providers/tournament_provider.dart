import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_helper.dart';
import '../models/tournament.dart';

class TournamentNotifier extends StateNotifier<List<Tournament>> {
  TournamentNotifier() : super([]) {
    loadTournaments();
  }

  final DatabaseHelper _database = DatabaseHelper.instance;

  Future<void> loadTournaments() async {
    state = await _database.getTournaments();
  }

  Future<void> addTournament(Tournament tournament) async {
    await _database.insertTournament(tournament);
    await loadTournaments();
  }

  Future<void> updateTournament(Tournament tournament) async {
    await _database.updateTournament(tournament);
    await loadTournaments();
  }

  Future<void> deleteTournament(int id) async {
    await _database.deleteTournament(id);
    await loadTournaments();
  }
}

final tournamentProvider =
    StateNotifierProvider<TournamentNotifier, List<Tournament>>(
      (ref) => TournamentNotifier(),
    );
