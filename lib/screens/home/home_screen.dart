import 'package:flutter/material.dart';

import '../../widgets/dashboard_card.dart';
import '../match/match_screen.dart';
import '../player/player_list_screen.dart';
import '../ranking/ranking_screen.dart';
import '../tournament/tournament_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Temporary default tournament ID.
  // Replace this with the selected tournament ID later.
  static const int defaultTournamentId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("♟ Chess Tournament Arena"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            const Icon(Icons.sports_esports, size: 80, color: Colors.indigo),

            const SizedBox(height: 16),

            const Center(
              child: Text(
                "Chess Tournament Management System",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            DashboardCard(
              title: "Player Management",
              subtitle: "Add, Edit and Delete Players",
              icon: Icons.people,
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PlayerListScreen()),
                );
              },
            ),

            DashboardCard(
              title: "Tournament Management",
              subtitle: "Create and Manage Tournaments",
              icon: Icons.emoji_events,
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TournamentListScreen(),
                  ),
                );
              },
            ),

            DashboardCard(
              title: "Start Tournament",
              subtitle: "Generate Random Matches",
              icon: Icons.casino,
              color: Colors.green,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const MatchScreen(tournamentId: defaultTournamentId),
                  ),
                );
              },
            ),

            DashboardCard(
              title: "Rankings",
              subtitle: "View Tournament Winners",
              icon: Icons.emoji_events_outlined,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const RankingScreen(tournamentId: defaultTournamentId),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
