import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/database_helper.dart';
import '../../models/match.dart';
import '../../models/player.dart';
import '../../providers/match_provider.dart';

class MatchScreen extends ConsumerStatefulWidget {
  final int tournamentId;

  const MatchScreen({super.key, required this.tournamentId});

  @override
  ConsumerState<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;

  Map<int, Player> playerMap = {};

  @override
  void initState() {
    super.initState();
    _loadPlayers();
    Future.microtask(() {
      ref.read(matchProvider.notifier).loadMatches(widget.tournamentId);
    });
  }

  Future<void> _loadPlayers() async {
    final players = await db.getPlayers();

    playerMap = {for (final player in players) player.id!: player};

    if (mounted) {
      setState(() {});
    }
  }

  String getPlayerName(int id) {
    return playerMap[id]?.name ?? "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    final matches = ref.watch(matchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tournament Matches"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.casino),
                    label: const Text("Generate"),
                    onPressed: () async {
                      try {
                        await ref
                            .read(matchProvider.notifier)
                            .generateTournament(widget.tournamentId);

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Tournament Generated Successfully",
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.emoji_events),
                    label: const Text("Winners"),
                    onPressed: () async {
                      await ref
                          .read(matchProvider.notifier)
                          .generateRandomWinners(widget.tournamentId);

                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Random Winners Generated"),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: matches.isEmpty
                ? const Center(
                    child: Text(
                      "No matches generated.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      Match match = matches[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                "Round ${match.round}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),

                              const Divider(),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Text(
                                      getPlayerName(match.player1Id),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const Text(
                                    "VS",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Expanded(
                                    child: Text(
                                      getPlayerName(match.player2Id),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              if (match.winnerId == null)
                                const Text(
                                  "Winner : Pending",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              else
                                Text(
                                  "🏆 Winner : ${getPlayerName(match.winnerId!)}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
