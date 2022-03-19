import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/model/note_model.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context)?.settings.arguments as NoteModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Note"),
        actions: [
          IconButton(
              onPressed: () {
                DatabaseProvider.db.deleteNote(note.id);
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              note.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            Text(note.body)
          ],
        ),
      ),
    );
  }
}
