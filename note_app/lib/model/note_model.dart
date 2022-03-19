class NoteModel {
  String id;
  String title;
  String body;
  String creationDate;

  NoteModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.creationDate});

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "creationDate": creationDate
    });
  }
}
