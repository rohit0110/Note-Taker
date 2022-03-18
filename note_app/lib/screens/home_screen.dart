import 'package:flutter/material.dart';
import 'package:note_app/db/database_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getNotes() async {
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Notes")),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, AsyncSnapshot noteData) {
          switch (noteData.connectionState) {
            case ConnectionState.waiting:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.done:
              {
                if (noteData.data == "") {
                  return const Center(
                    child: Text("Looks like you dont have any notes yet!"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView.builder(
                        itemCount: noteData.data.length,
                        itemBuilder: (context, index) {
                          String title = noteData.data[index]['title'];
                          String body = noteData.data[index]['body'];
                          String creationDate =
                              noteData.data[index]['creationDate'];
                          return Card(
                            child: ListTile(
                              title: Text(title),
                              subtitle: Text(body),
                            ),
                          );
                        }),
                  );
                }
              }
            case ConnectionState.active:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            case ConnectionState.none:
              {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/AddNote");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
