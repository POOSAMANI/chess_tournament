import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/database_helper.dart';
import '../../models/player.dart';
import '../../models/tournament.dart';
import '../../providers/player_provider.dart';

class ManagePlayersScreen extends ConsumerStatefulWidget {
  final Tournament tournament;

  const ManagePlayersScreen({super.key, required this.tournament});

  @override
  ConsumerState<ManagePlayersScreen> createState() =>
      _ManagePlayersScreenState();
}

class _ManagePlayersScreenState extends ConsumerState<ManagePlayersScreen> {
  final DatabaseHelper db = DatabaseHelper.instance;

  List<int> selectedPlayers = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSelectedPlayers();
  }

  Future<void> loadSelectedPlayers() async {
    selectedPlayers = await db.getTournamentPlayers(widget.tournament.id!);

    setState(() {
      loading = false;
    });
  }

  Future<void> savePlayers() async {
    await db.removeTournamentPlayers(widget.tournament.id!);

    for (final id in selectedPlayers) {
      await db.addPlayerToTournament(widget.tournament.id!, id);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "${selectedPlayers.length} player(s) assigned successfully",
        ),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final players = ref.watch(playerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.tournament.name)),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : players.isEmpty
          ? const Center(
              child: Text(
                "No players available.\nAdd players first.",
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.indigo.shade50,
                  child: Text(
                    "Selected Players : ${selectedPlayers.length}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      final Player player = players[index];

                      final selected = selectedPlayers.contains(player.id);

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: CheckboxListTile(
                          value: selected,
                          title: Text(
                            player.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Age : ${player.age}    Rating : ${player.rating}",
                          ),
                          secondary: CircleAvatar(
                            child: Text(player.id.toString()),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                if (!selectedPlayers.contains(player.id)) {
                                  selectedPlayers.add(player.id!);
                                }
                              } else {
                                selectedPlayers.remove(player.id);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text(
                        "SAVE PLAYERS",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: selectedPlayers.isEmpty ? null : savePlayers,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
