import 'package:flutter/material.dart';

import '../../models/tournament.dart';
import '../match/match_screen.dart';
import '../ranking/ranking_screen.dart';
import 'manage_players_screen.dart';

class TournamentDetailsScreen extends StatelessWidget {
  final Tournament tournament;

  const TournamentDetailsScreen({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tournament.name), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.emoji_events,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      tournament.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text("Location"),
                      subtitle: Text(tournament.location),
                    ),

                    ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text("Start Date"),
                      subtitle: Text(tournament.startDate),
                    ),

                    ListTile(
                      leading: const Icon(Icons.event),
                      title: const Text("End Date"),
                      subtitle: Text(tournament.endDate),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.people, color: Colors.white),
                ),
                title: const Text("Tournament Players"),
                subtitle: const Text("Assign players to this tournament"),
                trailing: ElevatedButton(
                  child: const Text("Manage"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ManagePlayersScreen(tournament: tournament),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.casino, color: Colors.white),
                ),
                title: const Text("Generate Tournament"),
                subtitle: const Text("Generate first round matches"),
                trailing: ElevatedButton(
                  child: const Text("Generate"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            MatchScreen(tournamentId: tournament.id!),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.leaderboard, color: Colors.white),
                ),
                title: const Text("Tournament Ranking"),
                subtitle: const Text("View tournament champion"),
                trailing: ElevatedButton(
                  child: const Text("Ranking"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            RankingScreen(tournamentId: tournament.id!),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text(
                  "START TOURNAMENT",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MatchScreen(tournamentId: tournament.id!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
