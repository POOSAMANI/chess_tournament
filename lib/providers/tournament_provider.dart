import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_helper.dart';
import '../models/tournament.dart';

class TournamentNotifier extends StateNotifier<List<Tournament>> {
  TournamentNotifier() : super([]) {
    loadTournaments();
  }

  final DatabaseHelper database = DatabaseHelper.instance;

  Future<void> loadTournaments() async {
    state = await database.getTournaments();
  }

  Future<void> addTournament(Tournament tournament) async {
    await database.insertTournament(tournament);
    await loadTournaments();
  }

  Future<void> updateTournament(Tournament tournament) async {
    await database.updateTournament(tournament);
    await loadTournaments();
  }

  Future<void> deleteTournament(int id) async {
    await database.deleteTournament(id);
    await loadTournaments();
  }
}

final tournamentProvider =
    StateNotifierProvider<TournamentNotifier, List<Tournament>>(
      (ref) => TournamentNotifier(),
    );
