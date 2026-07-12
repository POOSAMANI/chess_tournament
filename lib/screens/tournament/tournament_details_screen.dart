import 'package:flutter/material.dart';

import '../../models/tournament.dart';
import 'manage_players_screen.dart';

class TournamentDetailsScreen extends StatelessWidget {
  final Tournament tournament;

  const TournamentDetailsScreen({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tournament Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tournament Information Card
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
                      leading: const Icon(Icons.calendar_month),
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

            const SizedBox(height: 25),

            // Manage Players
            Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.people, color: Colors.white),
                ),
                title: const Text("Tournament Players"),
                subtitle: const Text(
                  "Manage players participating in this tournament",
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ManagePlayersScreen(tournament: tournament),
                      ),
                    );
                  },
                  child: const Text("Manage"),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Generate Tournament
            Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.casino, color: Colors.white),
                ),
                title: const Text("Generate Tournament"),
                subtitle: const Text(
                  "Randomly pair players and create matches",
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Tournament Generator Coming Soon 🚀"),
                      ),
                    );
                  },
                  child: const Text("Generate"),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Ranking
            Card(
              elevation: 3,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.leaderboard, color: Colors.white),
                ),
                title: const Text("Tournament Ranking"),
                subtitle: const Text(
                  "View Champion, Runner-up and Third Place",
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Ranking Module Coming Soon 🏆"),
                      ),
                    );
                  },
                  child: const Text("Ranking"),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tournament Engine Coming Soon 🚀"),
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
