///
/// Storage class for the todo item
///
class Todo {
  int id;
  bool done;
  String title;

  Todo({this.id, this.done, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'done': done,
    };
  }
}
