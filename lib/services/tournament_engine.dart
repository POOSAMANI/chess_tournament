import 'dart:math';

import '../database/database_helper.dart';
import '../models/match.dart';
import '../models/player.dart';

class TournamentEngine {
  TournamentEngine._();

  static final DatabaseHelper _db = DatabaseHelper.instance;

  /// Generate Round 1 for a tournament.
  static Future<List<Match>> generateRoundOne(int tournamentId) async {
    // Remove previous matches
    await _db.deleteMatches(tournamentId);

    // Load assigned players
    final List<Player> players = await _db.getPlayersForTournament(
      tournamentId,
    );

    if (players.length < 2) {
      throw Exception("At least two players are required.");
    }

    // Shuffle players
    players.shuffle(Random());

    final List<Match> matches = [];

    int round = 1;

    for (int i = 0; i < players.length; i += 2) {
      if (i + 1 >= players.length) break;

      final match = Match(
        tournamentId: tournamentId,
        round: round,
        player1Id: players[i].id!,
        player2Id: players[i + 1].id!,
      );

      final id = await _db.insertMatch(match);

      matches.add(match.copyWith(id: id));
    }

    return matches;
  }

  /// Randomly select winners for all matches in a tournament.
  static Future<void> generateRandomWinners(int tournamentId) async {
    final matches = await _db.getMatches(tournamentId);

    final random = Random();

    for (final match in matches) {
      final winner = random.nextBool() ? match.player1Id : match.player2Id;

      await _db.updateWinner(match.id!, winner);
    }
  }

  /// Get all winners from the latest round.
  static Future<List<int>> getRoundWinners(int tournamentId) async {
    final matches = await _db.getMatches(tournamentId);

    return matches
        .where((m) => m.winnerId != null)
        .map((m) => m.winnerId!)
        .toList();
  }
}
