class TodoModel {
  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone = false;

  TodoModel(this.title, this.description, this.isFavorite);
}
