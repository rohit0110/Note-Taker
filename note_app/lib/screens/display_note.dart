import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';
import 'package:note_app/model/note_model.dart';

class ShowNote extends StatefulWidget {
  const ShowNote({Key? key}) : super(key: key);

  @override
  State<ShowNote> createState() => _ShowNoteState();
}

class _ShowNoteState extends State<ShowNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool saveButton = false;
  String title = '';
  String body = '';

  Widget _getFAB(String title, String body, String id) {
    if (saveButton) {
      return FloatingActionButton(
        onPressed: () {
          updateNotes(id, title, body);
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        child: const Icon(Icons.save),
      );
    } else {
      return Container();
    }
  }

  updateNotes(String id, String title, String body) {
    DatabaseProvider.db.updateNotes(id, body, title);
  }

  setVals(NoteModel note) {
    title = note.title;
    body = note.body;
  }

  @override
  Widget build(BuildContext context) {
    final NoteModel note =
        ModalRoute.of(context)?.settings.arguments as NoteModel;
    saveButton ? null : setVals(note);
    // setVals(note);
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
            // Text(
            //   note.title,
            //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            // ),
            // Text(note.body)
            TextField(
              controller: titleController
                ..text = title
                ..selection = TextSelection.collapsed(offset: title.length),
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Note Title"),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              onChanged: (text) {
                setState(() {
                  title = titleController.text;
                  saveButton = true;
                });
              },
            ),
            Expanded(
                child: TextField(
              controller: bodyController
                ..text = body
                ..selection = TextSelection.collapsed(offset: body.length),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: "Enter Note"),
              onChanged: (text) {
                setState(() {
                  body = bodyController.text;
                  saveButton = true;
                });
              },
            ))
          ],
        ),
      ),
      floatingActionButton: _getFAB(title, body, note.id),
    );
  }
}
