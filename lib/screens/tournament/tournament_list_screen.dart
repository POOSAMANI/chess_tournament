import 'package:flutter/material.dart';

import 'add_tournament_screen.dart';

class TournamentListScreen extends StatelessWidget {
  const TournamentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tournaments")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTournamentScreen()),
          );
        },
      ),
      body: const Center(
        child: Text("No tournaments available", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
