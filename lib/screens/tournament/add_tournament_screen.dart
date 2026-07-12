import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/tournament.dart';
import '../../providers/tournament_provider.dart';

class AddTournamentScreen extends ConsumerStatefulWidget {
  final Tournament? tournament;

  const AddTournamentScreen({super.key, this.tournament});

  @override
  ConsumerState<AddTournamentScreen> createState() =>
      _AddTournamentScreenState();
}

class _AddTournamentScreenState extends ConsumerState<AddTournamentScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.tournament != null) {
      nameController.text = widget.tournament!.name;
      locationController.text = widget.tournament!.location;
      startDateController.text = widget.tournament!.startDate;
      endDateController.text = widget.tournament!.endDate;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Future<void> saveTournament() async {
    if (!_formKey.currentState!.validate()) return;

    final tournament = Tournament(
      id: widget.tournament?.id,
      name: nameController.text.trim(),
      location: locationController.text.trim(),
      startDate: startDateController.text.trim(),
      endDate: endDateController.text.trim(),
    );

    if (widget.tournament == null) {
      await ref.read(tournamentProvider.notifier).addTournament(tournament);
    } else {
      await ref.read(tournamentProvider.notifier).updateTournament(tournament);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.tournament != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Tournament" : "Add Tournament"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Tournament Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter tournament name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: "Location",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: startDateController,
                decoration: const InputDecoration(
                  labelText: "Start Date",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: endDateController,
                decoration: const InputDecoration(
                  labelText: "End Date",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: saveTournament,
                  child: Text(isEdit ? "Update Tournament" : "Save Tournament"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
