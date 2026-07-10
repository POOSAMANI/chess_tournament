import 'package:flutter/material.dart';

import '../player/player_list_screen.dart';
import '../tournament/tournament_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chess Tournament Manager"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 10),

            const Icon(Icons.sports_esports, size: 80, color: Colors.indigo),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                "Chess Tournament Management System",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            _menuCard(
              context,
              title: "Player Management",
              subtitle: "Add, Edit and Delete Players",
              icon: Icons.people,
              color: Colors.blue,
              page: const PlayerListScreen(),
            ),

            const SizedBox(height: 15),

            _menuCard(
              context,
              title: "Tournament Management",
              subtitle: "Create Chess Tournaments",
              icon: Icons.emoji_events,
              color: Colors.orange,
              page: const TournamentListScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page));
        },
      ),
    );
  }
}
