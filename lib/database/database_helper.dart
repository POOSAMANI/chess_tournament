import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/player.dart';
import '../models/tournament.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'chess_tournament.db');

    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE players(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL,
        rating INTEGER NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tournaments(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        location TEXT,
        startDate TEXT,
        endDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE tournament_players(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tournamentId INTEGER,
        playerId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE matches(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tournamentId INTEGER,
        round INTEGER,
        player1 INTEGER,
        player2 INTEGER,
        winner INTEGER
      )
    ''');
  }

  // ===========================
  // PLAYER CRUD
  // ===========================

  Future<int> insertPlayer(Player player) async {
    final db = await database;

    return await db.insert(
      'players',
      player.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Player>> getPlayers() async {
    final db = await database;

    final maps = await db.query('players', orderBy: 'id DESC');

    return List.generate(maps.length, (index) => Player.fromMap(maps[index]));
  }

  Future<int> updatePlayer(Player player) async {
    final db = await database;

    return await db.update(
      'players',
      player.toMap(),
      where: 'id=?',
      whereArgs: [player.id],
    );
  }

  Future<int> deletePlayer(int id) async {
    final db = await database;

    return await db.delete('players', where: 'id=?', whereArgs: [id]);
  }

  // ===========================
  // TOURNAMENT CRUD
  // ===========================

  Future<int> insertTournament(Tournament tournament) async {
    final db = await database;

    return await db.insert(
      'tournaments',
      tournament.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Tournament>> getTournaments() async {
    final db = await database;

    final maps = await db.query('tournaments', orderBy: 'id DESC');

    return List.generate(
      maps.length,
      (index) => Tournament.fromMap(maps[index]),
    );
  }

  Future<int> updateTournament(Tournament tournament) async {
    final db = await database;

    return await db.update(
      'tournaments',
      tournament.toMap(),
      where: 'id=?',
      whereArgs: [tournament.id],
    );
  }

  Future<int> deleteTournament(int id) async {
    final db = await database;

    return await db.delete('tournaments', where: 'id=?', whereArgs: [id]);
  }

  // ===========================
  // TOURNAMENT PLAYERS
  // ===========================

  Future<void> addPlayerToTournament(int tournamentId, int playerId) async {
    final db = await database;

    await db.insert('tournament_players', {
      'tournamentId': tournamentId,
      'playerId': playerId,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<int>> getTournamentPlayers(int tournamentId) async {
    final db = await database;

    final result = await db.query(
      'tournament_players',
      where: 'tournamentId=?',
      whereArgs: [tournamentId],
    );

    return result.map((e) => e['playerId'] as int).toList();
  }

  Future<void> removeTournamentPlayers(int tournamentId) async {
    final db = await database;

    await db.delete(
      'tournament_players',
      where: 'tournamentId=?',
      whereArgs: [tournamentId],
    );
  }
}
