class Match {
  final int? id;
  final int tournamentId;
  final int round;
  final int player1Id;
  final int player2Id;
  final int? winnerId;

  const Match({
    this.id,
    required this.tournamentId,
    required this.round,
    required this.player1Id,
    required this.player2Id,
    this.winnerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tournamentId': tournamentId,
      'round': round,
      'player1': player1Id,
      'player2': player2Id,
      'winner': winnerId,
    };
  }

  factory Match.fromMap(Map<String, dynamic> map) {
    return Match(
      id: map['id'] as int?,
      tournamentId: map['tournamentId'] as int,
      round: map['round'] as int,
      player1Id: map['player1'] as int,
      player2Id: map['player2'] as int,
      winnerId: map['winner'] as int?,
    );
  }

  Match copyWith({
    int? id,
    int? tournamentId,
    int? round,
    int? player1Id,
    int? player2Id,
    int? winnerId,
  }) {
    return Match(
      id: id ?? this.id,
      tournamentId: tournamentId ?? this.tournamentId,
      round: round ?? this.round,
      player1Id: player1Id ?? this.player1Id,
      player2Id: player2Id ?? this.player2Id,
      winnerId: winnerId ?? this.winnerId,
    );
  }
}
