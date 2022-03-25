import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/model/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title = '';
  String body = '';
  String creationDate = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  addNote(NoteModel note) {
    DatabaseProvider.db.addNewNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Note Title"),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Enter Note"),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            creationDate = DateTime.now().toString();
          });
          NoteModel note = NoteModel(
              id: UniqueKey().toString(),
              title: title,
              body: body,
              creationDate: creationDate);
          addNote(note);
          Navigator.pushNamedAndRemoveUntil(context, "/", ((route) => false));
        },
        label: const Text("Save Note"),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
