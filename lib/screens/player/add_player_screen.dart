import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/player.dart';
import '../../providers/player_provider.dart';

class AddPlayerScreen extends ConsumerStatefulWidget {
  final Player? player;

  const AddPlayerScreen({super.key, this.player});

  @override
  ConsumerState<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends ConsumerState<AddPlayerScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.player != null) {
      nameController.text = widget.player!.name;
      ageController.text = widget.player!.age.toString();
      ratingController.text = widget.player!.rating.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  Future<void> _savePlayer() async {
    if (!_formKey.currentState!.validate()) return;

    final player = Player(
      id: widget.player?.id,
      name: nameController.text.trim(),
      age: int.parse(ageController.text),
      rating: int.parse(ratingController.text),
    );

    if (widget.player == null) {
      await ref.read(playerProvider.notifier).addPlayer(player);
    } else {
      await ref.read(playerProvider.notifier).updatePlayer(player);
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.player != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Player" : "Add Player")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Player Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter player name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter age";
                  }

                  if (int.tryParse(value) == null) {
                    return "Enter a valid age";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Rating",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter rating";
                  }

                  if (int.tryParse(value) == null) {
                    return "Enter a valid rating";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _savePlayer,
                  child: Text(isEdit ? "Update Player" : "Save Player"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
