import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/match.dart';
import '../../models/player.dart';

class RankingScreen extends StatefulWidget {
  final int tournamentId;

  const RankingScreen({super.key, required this.tournamentId});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;

  List<Match> matches = [];
  Map<int, Player> players = {};

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final allPlayers = await db.getPlayers();

    players = {for (final p in allPlayers) p.id!: p};

    matches = await db.getMatches(widget.tournamentId);

    setState(() {
      loading = false;
    });
  }

  Player? getChampion() {
    if (matches.isEmpty) return null;

    final completed = matches.where((m) => m.winnerId != null).toList();

    if (completed.isEmpty) return null;

    final score = <int, int>{};

    for (final match in completed) {
      score[match.winnerId!] = (score[match.winnerId!] ?? 0) + 1;
    }

    int championId = score.entries.first.key;
    int maxWins = score.entries.first.value;

    score.forEach((id, wins) {
      if (wins > maxWins) {
        championId = id;
        maxWins = wins;
      }
    });

    return players[championId];
  }

  @override
  Widget build(BuildContext context) {
    final champion = getChampion();

    return Scaffold(
      appBar: AppBar(title: const Text("Tournament Ranking")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : champion == null
          ? const Center(child: Text("Tournament has not finished yet."))
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  const Icon(
                    Icons.emoji_events,
                    color: Colors.amber,
                    size: 100,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Champion",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    champion.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Rating : ${champion.rating}",
                    style: const TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 50),

                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.info),
                      title: Text(
                        "Runner-up and Third Place will be available after multi-round tournament support is added.",
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
